import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_similarity/string_similarity.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List quranData = [];
  String result = "";

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadQuran();
  }

  Future loadQuran() async {
    String data = await rootBundle.loadString('assets/quran_test.json');
    setState(() {
      quranData = json.decode(data);
    });
  }

  void searchAyah() {
    String input = controller.text;

    double bestScore = 0;
    Map? bestMatch;

    for (var ayah in quranData) {
      double similarity = StringSimilarity.compareTwoStrings(
        input,
        ayah["text"],
      );

      if (similarity > bestScore) {
        bestScore = similarity;
        bestMatch = ayah;
      }
    }

    if (bestMatch != null && bestScore > 0.4) {
      setState(() {
        result =
            "الصفحة: ${bestMatch!["page"]}\nالسورة: ${bestMatch["surah"]}\nSimilarity: ${bestScore.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        result = "لم يتم العثور على آية مشابهة";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quran Search Test")),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "اكتب آية"),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: searchAyah, child: Text("Search")),

            SizedBox(height: 30),

            Text(result, style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}

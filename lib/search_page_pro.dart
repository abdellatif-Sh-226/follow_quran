import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_similarity/string_similarity.dart';

class SearchPage1 extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage1> {
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
    String input = controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        result = "اكتب كلمة أو نص للبحث";
      });
      return;
    }

    List<String> words = input.split(" ");

    List<Map> filtered = [];

    for (var ayah in quranData) {
      for (var word in words) {
        if (ayah["text"].contains(word)) {
          filtered.add(ayah);
          break;
        }
      }
    }

    if (filtered.isEmpty) {
      setState(() {
        result = "لم يتم العثور على آية تحتوي على هذه الكلمات";
      });
      return;
    }

    double bestScore = 0;
    Map? bestMatch;

    for (var ayah in filtered) {
      double similarity = StringSimilarity.compareTwoStrings(
        input,
        ayah["text"],
      );
      if (similarity > bestScore) {
        bestScore = similarity;
        bestMatch = ayah;
      }
    }

    if (bestMatch != null && bestScore > 0.3) {
      // Threshold
      setState(() {
        result =
            "الصفحة: ${bestMatch!["page"]} \nسورة: ${bestMatch["surah"]} \nتشابه: ${bestScore.toStringAsFixed(2)}";
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
      appBar: AppBar(title: Text("Quran Word Search Test")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "اكتب كلمة أو جزء من الآية",
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: searchAyah, child: Text("بحث")),

            SizedBox(height: 30),

            Text(result, style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_similarity/string_similarity.dart';

class SearchPage3AyatV2 extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage3AyatV2> {
  List quranData = [];
  List chunks = [];
  String result = "";

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadQuranAndBuildChunks();
  }

  Future<void> loadQuranAndBuildChunks() async {
    List allAyat = await loadQuran();
    setState(() {
      quranData = allAyat;
      chunks = buildChunks(allAyat);
    });
  }

  Future<List> loadQuran() async {
    List allAyat = [];
    for (int i = 1; i <= 114; i++) {
      try {
        String data = await rootBundle.loadString('assets/quran/surah_$i.json');
        List surah = jsonDecode(data);
        allAyat.addAll(surah);
      } catch (e) {
        print("Erreur loading surah_$i.json : $e");
      }
    }
    return allAyat;
  }

  List buildChunks(List data) {
    List list = [];
    for (int i = 0; i < data.length - 2; i++) {
      if (data[i]["surah"] == data[i + 1]["surah"] &&
          data[i]["surah"] == data[i + 2]["surah"]) {
        String combined =
            "${data[i]["text"]} ${data[i + 1]["text"]} ${data[i + 2]["text"]}";

        list.add({
          "text": combined,
          "page": data[i]["page"],
          "surah": data[i]["surah"],
          "ayah": "${data[i + 2]["ayah"]}",
        });
      }
    }
    return list;
  }

  void searchAyah() {
    String input = controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        result = "اكتب نص للبحث";
      });
      return;
    }

    double bestScore = 0;
    Map? bestMatch;

    for (var chunk in chunks) {
      double similarity = StringSimilarity.compareTwoStrings(
        input,
        chunk["text"],
      );

      if (similarity > bestScore) {
        bestScore = similarity;
        bestMatch = chunk;
      }
    }

    if (bestMatch != null && bestScore > 0.1) {
      setState(() {
        result =
            "السورة: ${bestMatch?["surah"]}\nالآية: ${bestMatch?["ayah"]}\nالصفحة: ${bestMatch?["page"]}\nتشابه: ${bestScore.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        result = "لم يتم العثور على نتيجة";
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
              decoration: InputDecoration(labelText: "اكتب آية أو أكثر"),
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

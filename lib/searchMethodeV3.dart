import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPageDirect extends StatefulWidget {
  @override
  _SearchPageDirectState createState() => _SearchPageDirectState();
}

class _SearchPageDirectState extends State<SearchPageDirect> {
  List quranData = [];
  String result = "";

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadQuran();
  }

  Future<void> loadQuran() async {
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
    setState(() {
      quranData = allAyat;
    });
  }

  void searchAyahDirect() {
    String input = controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        result = "اكتب نص للبحث";
      });
      return;
    }

    List<Map> matches = [];

    for (var ayah in quranData) {
      if (ayah["text"].contains(input)) {
        matches.add(ayah);
      }
    }

    if (matches.isNotEmpty) {
      var firstMatch = matches[0];
      setState(() {
        result =
            "السورة: ${firstMatch["surah"]}\nالآية: ${firstMatch["ayah"]}\nالصفحة: ${firstMatch["page"]}\nالنص: ${firstMatch["text"]}";
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
      appBar: AppBar(title: Text("Quran Direct Search")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "اكتب آية أو كلمة",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: searchAyahDirect, child: Text("Search")),
            SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Text(result, style: TextStyle(fontSize: 22)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

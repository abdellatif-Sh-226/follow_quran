import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  String removeTashkeel(String text) {
    return text.replaceAll(RegExp(r'[ًٌٍَُِّْۚۛۖۗۜ۟ۡۥࣰࣱٰۢۤ]'), '');
  }

  String cleanText(String text) {
    String noTashkeel = removeTashkeel(text);
    return noTashkeel.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  for (int surahNumber = 1; surahNumber <= 114; surahNumber++) {
    print("جاري تحميل السورة $surahNumber");

    var response = await http.get(
      Uri.parse("https://api.alquran.cloud/v1/surah/$surahNumber"),
    );

    if (response.statusCode != 200) {
      print("Error loading surah $surahNumber");
      continue;
    }

    var data = jsonDecode(response.body);
    var ayahs = data["data"]["ayahs"];
    var surahName = data["data"]["englishName"];

    List result = [];

    for (var a in ayahs) {
      result.add({
        "surah": surahName,
        "ayah": a["numberInSurah"],
        "text": cleanText(a["text"]),
        "page": a["page"],
      });
    }

    var jsonString = JsonEncoder.withIndent("  ").convert(result);

    File file = File('surah_$surahNumber.json');
    await file.writeAsString(jsonString);

    print("created successfully: surah_$surahNumber.json");
  }

  print("done");
}

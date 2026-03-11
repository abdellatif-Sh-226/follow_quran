import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  int surahNumber = 54; // رقم السورة الي تحب تجيبها (مثال: الإخلاص)

  // جلب البيانات من API
  var response = await http.get(
    Uri.parse("https://api.alquran.cloud/v1/surah/$surahNumber"),
  );

  if (response.statusCode != 200) {
    print("خطأ في تحميل السورة!");
    return;
  }

  var data = jsonDecode(response.body);
  var ayahs = data["data"]["ayahs"];
  var surahName =
      data["data"]["englishName"]; // أو data["data"]["name"] بالعربي

  List result = [];
  String removeTashkeel(String text) {
    // حذف كل الحركات وعلامات القرآن + الرموز الخاصة
    return text.replaceAll(RegExp(r'[ًٌٍَُِّْۚۛۖۗۜ۟ۡۥࣰࣱٰۢۤ]'), '');
  }

  String cleanText(String text) {
    String noTashkeel = removeTashkeel(text);
    return noTashkeel.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  for (var a in ayahs) {
    result.add({
      "surah": surahName,
      "ayah": a["numberInSurah"],
      "text": cleanText(a["text"]), // النص يتنظف قبل ما يتحط
      "page": a["page"],
    });
  }

  // تحويل JSON لString منسق
  var jsonString = JsonEncoder.withIndent("  ").convert(result);

  // حفظ في ملف JSON
  File file = File('surah_$surahNumber.json');
  await file.writeAsString(jsonString);

  print("تم إنشاء الملف: surah_$surahNumber.json");
}

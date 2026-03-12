import 'package:flutter/material.dart';
import 'package:follow_quran/search_page_with3Ayat_V2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Quran Voice Test', home: SearchPage3AyatV2());
  }
}

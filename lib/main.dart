import 'package:flutter/material.dart';
//import 'package:follow_quran/microTest.dart';
import 'package:follow_quran/search_page_pro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Quran Voice Test', home: SearchPage1());
  }
}

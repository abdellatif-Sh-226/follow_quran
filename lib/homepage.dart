import 'package:flutter/material.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quran App")),
      body: Center(
        child: ElevatedButton(
          child: Text("Search Ayah"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void reset() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Test Counter", style: TextStyle(fontSize: 24)),

            SizedBox(height: 20),

            Text("$counter", style: TextStyle(fontSize: 40)),

            SizedBox(height: 30),

            ElevatedButton(onPressed: increment, child: Text("Increment")),

            SizedBox(height: 10),

            ElevatedButton(onPressed: reset, child: Text("Reset")),
          ],
        ),
      ),
    );
  }
}

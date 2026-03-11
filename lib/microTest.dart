import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoicePage extends StatefulWidget {
  @override
  _VoicePageState createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  SpeechToText speech = SpeechToText();
  String text = "اضغط على الميكروفون وابدأ القراءة";

  void startListening() async {
    bool available = await speech.initialize();

    if (available) {
      speech.listen(
        localeId: "ar",
        onResult: (result) {
          setState(() {
            text = result.recognizedWords;
          });
        },
      );
    }
  }

  void stopListening() {
    speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quran Voice Test")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40),

              ElevatedButton(
                onPressed: startListening,
                child: Text("🎤 Start Mic"),
              ),

              ElevatedButton(onPressed: stopListening, child: Text("Stop")),
            ],
          ),
        ),
      ),
    );
  }
}

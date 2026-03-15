import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioQuranPage extends StatefulWidget {
  @override
  _AudioQuranPageState createState() => _AudioQuranPageState();
}

class _AudioQuranPageState extends State<AudioQuranPage> {
  final AudioPlayer player = AudioPlayer();

  TextEditingController surahController = TextEditingController();
  TextEditingController ayahController = TextEditingController();

  String audioUrl = "";

  String generateUrl() {
    String surah = surahController.text.padLeft(3, '0');
    String ayah = ayahController.text.padLeft(3, '0');

    return "https://everyayah.com/data/Alafasy_128kbps/$surah$ayah.mp3";
  }

  void playAudio() async {
    String url = generateUrl();

    setState(() {
      audioUrl = url;
    });

    await player.play(UrlSource(url));
  }

  void stopAudio() async {
    await player.stop();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quran Audio Player")),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: surahController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Surah Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: ayahController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ayah Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: playAudio, child: Text("Play")),

                ElevatedButton(onPressed: stopAudio, child: Text("Stop")),
              ],
            ),

            SizedBox(height: 30),

            Text("Audio URL:", style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            Text(audioUrl),
          ],
        ),
      ),
    );
  }
}

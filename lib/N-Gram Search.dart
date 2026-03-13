List<String> makeNgrams(String text, int n) {
  List words = text.split(" ");
  List<String> grams = [];

  for (int i = 0; i <= words.length - n; i++) {
    grams.add(words.sublist(i, i + n).join(" "));
  }

  return grams;
}

Map? searchNgram(String input, List quran) {
  List inputGrams = makeNgrams(input, 3);

  Map? bestMatch;
  int bestScore = 0;

  for (var verse in quran) {
    List verseGrams = makeNgrams(verse["text"], 3);

    int score = 0;

    for (var g in inputGrams) {
      if (verseGrams.contains(g)) {
        score++;
      }
    }

    if (score > bestScore) {
      bestScore = score;
      bestMatch = verse;
    }
  }

  return bestMatch;
}

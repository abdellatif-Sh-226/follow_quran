Map? searchWordMatching(String input, List quran) {
  List inputWords = input.split(" ");

  Map? bestMatch;
  int bestScore = 0;

  for (var verse in quran) {
    String text = verse["text"];
    List verseWords = text.split(" ");

    int score = 0;

    for (var w in inputWords) {
      if (verseWords.contains(w)) {
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

int levenshtein(String s, String t) {
  int m = s.length;
  int n = t.length;

  List<List<int>> d = List.generate(m + 1, (_) => List.filled(n + 1, 0));

  for (int i = 0; i <= m; i++) d[i][0] = i;
  for (int j = 0; j <= n; j++) d[0][j] = j;

  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      int cost = s[i - 1] == t[j - 1] ? 0 : 1;

      d[i][j] = [
        d[i - 1][j] + 1,
        d[i][j - 1] + 1,
        d[i - 1][j - 1] + cost,
      ].reduce((a, b) => a < b ? a : b);
    }
  }

  return d[m][n];
}

Map? searchLevenshtein(String input, List quran) {
  Map? bestMatch;
  int bestScore = 999999;

  for (var verse in quran) {
    String text = verse["text"];

    int dist = levenshtein(input, text);

    if (dist < bestScore) {
      bestScore = dist;
      bestMatch = verse;
    }
  }

  return bestMatch;
}

class QueryBuilder {
  String buildQuery(String gameTitle) {
    if (gameTitle.contains(' ')) {
      gameTitle = gameTitle.replaceAll(' ', '-');
    }
    return 'https://api.rawg.io/api/games/$gameTitle?key=8ecd5215484b49d1af3cb570778ce30f';
  }
}

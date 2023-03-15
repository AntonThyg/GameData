class NetworkAccess {
  String querySpecific(String gameTitle) {
    if (gameTitle.contains(' ')) {
      gameTitle = gameTitle.replaceAll(' ', '-');
    }
    if (gameTitle.contains(':')) {
      gameTitle = gameTitle.replaceAll(':', '');
    }
    if (gameTitle.contains(';')) {
      gameTitle = gameTitle.replaceAll(';', '');
    }
    return 'https://api.rawg.io/api/games/$gameTitle?key=8ecd5215484b49d1af3cb570778ce30f';
  }

  String queryUpcoming() {
    var currentDate = DateTime.now().toString().split(' ')[0];
    var endDate =
        DateTime.now().add(const Duration(days: 365)).toString().split(' ')[0];
    return 'https://api.rawg.io/api/games?dates=$currentDate,$endDate&ordering=released&key=8ecd5215484b49d1af3cb570778ce30f';
  }
}

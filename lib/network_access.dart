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
    return 'https://api.rawg.io/api/games/$gameTitle?key=33b90247a9b44a59b04d9d1e5871cac0';
  }

  String queryUpcoming() {
    var currentDate = DateTime.now().toString().split(' ')[0];
    var endDate =
        DateTime.now().add(const Duration(days: 365)).toString().split(' ')[0];
    return 'https://api.rawg.io/api/games?dates=$currentDate,$endDate&ordering=released&key=33b90247a9b44a59b04d9d1e5871cac0';
  }
}

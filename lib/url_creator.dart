import 'dart:io';

class UrlCreator {
  // final String _key = File("lib/key.gitignore").readAsStringSync();

  String createSpecificQueryUrl(String gameTitle) {
    if (gameTitle.contains(' ')) {
      gameTitle = gameTitle.replaceAll(' ', '-');
    }
    if (gameTitle.contains(':')) {
      gameTitle = gameTitle.replaceAll(':', '');
    }
    if (gameTitle.contains(';')) {
      gameTitle = gameTitle.replaceAll(';', '');
    }
    return 'https://api.rawg.io/api/games/$gameTitle?key=';
  }

  String createUpcomingGamesQueryUrl() {
    String currentDate = DateTime.now().toString().split(' ')[0];
    String endDate =
        DateTime.now().add(const Duration(days: 365)).toString().split(' ')[0];
    return 'https://api.rawg.io/api/games?dates=$currentDate,$endDate&ordering=released&key=';
  }
}

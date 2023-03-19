import 'package:game_data/game.dart';
import 'package:game_data/json_parser.dart';
import 'package:game_data/network_access.dart';

class GameListCreator {
  List createListOfSlugs(var parsedJsonData) {
    List listOfGameSlugs = [];
    final numberOfGames = parsedJsonData['results'].length;
    for (int i = 0; i < numberOfGames; i++) {
      String slug = parsedJsonData['results'][i]['slug'];
      listOfGameSlugs.add(slug);
    }
    return listOfGameSlugs;
  }

  Future<List<Game>> createListOfGames(var listOfNames) async {
    List<Game> listOfGames = [];

    NetworkAccess accessNetwork = NetworkAccess();
    JsonParser jsonParser = JsonParser();

    for (int i = 0; i < listOfNames.length; i++) {
      String url = accessNetwork.querySpecific(listOfNames[i]);
      var jsonData = await jsonParser.parseJson(url);

      String name = jsonData["name"];
      String description = jsonData["description"];
      int rating = 0;
      if (jsonData["metacritic"] != null) {
        rating = jsonData["metacritic"];
      }
      DateTime releaseDate = DateTime.parse(jsonData["released"]);
      String imageUrl = '';
      if (jsonData["background_image"] == null) {
        imageUrl =
            'https://t4.ftcdn.net/jpg/02/51/95/53/360_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg';
      } else {
        imageUrl = jsonData["background_image"];
      }

      Game game = Game(name, description, rating, releaseDate, imageUrl);

      listOfGames.add(game);
    }
    return listOfGames;
  }
}

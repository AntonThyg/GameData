import 'package:game_data/game.dart';
import 'package:game_data/json_parser.dart';
import 'package:game_data/network_access.dart';

class GameListCreator {
  List createListOfNames(var parsedJsonData) {
    List listOfGameNames = [];
    final numberOfGames = parsedJsonData['results'].length;
    for (int i = 0; i < numberOfGames; i++) {
      String name = parsedJsonData['results'][i]['slug'];
      listOfGameNames.add(name);
    }
    return listOfGameNames;
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
      String imageUrl = jsonData["background_image"];

      Game game = Game(name, description, rating, releaseDate, imageUrl);

      listOfGames.add(game);
    }
    return listOfGames;
  }
}

Future<void> main() async {
  GameListCreator gameListCreator = GameListCreator();
  NetworkAccess networkAccess = NetworkAccess();
  var url = networkAccess.queryUpcoming();
  var names =
      gameListCreator.createListOfNames(await JsonParser().parseJson(url));
  var games = await gameListCreator.createListOfGames(names);

  for (Game g in games) {
    print(g.name);
  }
}

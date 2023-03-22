import 'package:game_data/game.dart';
import 'package:game_data/json_parser.dart';
import 'package:game_data/network_access.dart';

import 'game_creator.dart';

class ListCreator {
  List createListOfSlugs(var parsedJsonData) {
    List listOfGameSlugs = [];
    final numberOfGames = parsedJsonData['results'].length;
    for (int i = 0; i < numberOfGames; i++) {
      String slug = parsedJsonData['results'][i]['slug'];
      listOfGameSlugs.add(slug);
    }
    return listOfGameSlugs;
  }

  Future<List<Game>> createListOfGames(var listOfSlugs) async {
    List<Game> listOfGames = [];

    NetworkAccess accessNetwork = NetworkAccess();
    JsonParser jsonParser = JsonParser();
    GameCreator gameCreator = GameCreator();

    for (int i = 0; i < listOfSlugs.length; i++) {
      String url = accessNetwork.querySpecific(listOfSlugs[i]);
      final jsonData = await jsonParser.parseJsonFromUrl(url);
      listOfGames.add(gameCreator.createGameFromJson(jsonData));
    }
    return listOfGames;
  }
}

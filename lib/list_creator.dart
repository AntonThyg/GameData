import 'package:game_data/game.dart';
import 'package:game_data/json_decoder.dart';
import 'package:game_data/url_creator.dart';

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

    UrlCreator urlCreator = UrlCreator();
    JsonDecoder jsonDecoder = JsonDecoder();
    GameCreator gameCreator = GameCreator();

    for (int i = 0; i < listOfSlugs.length; i++) {
      String url = urlCreator.createSpecificQueryUrl(listOfSlugs[i]);
      final jsonData = await jsonDecoder.decodeJsonFromUrl(url);
      listOfGames.add(gameCreator.createGameFromJson(jsonData));
    }
    return listOfGames;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/games_list_creator.dart';

void main() {
  final testFile = File('test/upcoming_games.json');
  final stringData = testFile.readAsStringSync();
  final decodedJsonObject = jsonDecode(stringData);

  test('i can get the first slug from the list of upcoming games', () {
    GameListCreator gameListCreator = GameListCreator();
    var gameList = gameListCreator.createListOfSlugs(decodedJsonObject);
    var firstSlug = decodedJsonObject["results"][0]["slug"];
    expect(gameList[0], firstSlug);
  });
}

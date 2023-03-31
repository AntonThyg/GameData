import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/game_creator.dart';

void main() {
  GameCreator gameCreator = GameCreator();

  final testFile = File('test/minecraft.json');
  final stringData = testFile.readAsStringSync();
  final decodedJsonObject = jsonDecode(stringData);

  test("if the release date is 2009-05-10, getMonthName will return 'May.'",
      () {
    String expected =
        gameCreator.getMonthName(DateTime.parse(decodedJsonObject["released"]));
    expect(expected, "May");
  });

  test(
      "if the release date is 2009-05-10, getGameReleaseDate will return May 10, 2009",
      () {
    String expected = gameCreator.getGameReleaseDate(decodedJsonObject);
    expect(expected, "May 10, 2009");
  });
}

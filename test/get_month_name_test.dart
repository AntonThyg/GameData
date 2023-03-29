import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/game.dart';
import 'package:game_data/game_creator.dart';

void main() {
  GameCreator gameCreator = GameCreator();

  final testFile = File('test/minecraft.json');
  final stringData = testFile.readAsStringSync();
  final decodedJsonObject = jsonDecode(stringData);

  test("if the release date is 2009-05-10, getMonthName will return 'May.'",
      () {
    Game minecraft = gameCreator.createGameFromJson(decodedJsonObject);
    String expected = gameCreator.getMonthName(minecraft.releaseDateISO);
    expect(expected, "May");
  });
}

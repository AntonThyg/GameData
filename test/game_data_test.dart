import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final testFile = File('test/minecraft.json');
  final stringData = testFile.readAsStringSync();
  final decodedJsonObject = jsonDecode(stringData);

  test('i can get the description of a game from a json object', () {
    final gameDescription = decodedJsonObject['description'];
    final expected =
        startsWith('<p>One of the most popular games of the 2010s');
    expect(gameDescription, expected);
  });

  test('i can get the name of a game from a json object', () {
    final gameDescription = decodedJsonObject['name'];
    final expected = startsWith('Minecraft');
    expect(gameDescription, expected);
  });

  test('i can get the rating of a game from a json object', () {
    final gameDescription = decodedJsonObject['metacritic'];
    expect(gameDescription, 83);
  });

  test('i can get the release date of a game from a json object', () {
    final gameDescription = decodedJsonObject['released'];
    final expected = startsWith("2009-05-10");
    expect(gameDescription, expected);
  });
}

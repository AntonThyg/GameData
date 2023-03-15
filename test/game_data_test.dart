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
}

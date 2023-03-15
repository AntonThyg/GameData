import 'dart:io';
import 'dart:math';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

String? siteInfo;

void main() {
  String minecraftInfo = '';
  File('test/minecraft.json').readAsString().then((String contents) {
    minecraftInfo = contents;
  });
  print(minecraftInfo);

  test('siteinfo returns correctly', () {
    _getSiteInfo();
    expect(minecraftInfo, siteInfo);
  });
}

void _getSiteInfo() async {
  final url = 'https://api.rawg.io/api/games/minecraft?key=';
  final response = await http.get(Uri.parse(url));
  siteInfo = response.body;
  print(siteInfo);
}

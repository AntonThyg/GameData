import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/game_creator.dart';
import 'package:game_data/home_page_widget.dart';
import 'package:game_data/list_creator.dart';
import 'package:game_data/json_decoder.dart';
import 'package:game_data/url_creator.dart';

List<Game> favoritesList = [];
final gameCreator = GameCreator();
final listCreator = ListCreator();
final urlCreator = UrlCreator();
final jsonDecoder = JsonDecoder();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEAS Co.',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        canvasColor: Colors.white60,
      ),
      home: const Scaffold(body: MyHomePage()),
    );
  }
}

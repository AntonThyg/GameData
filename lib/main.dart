import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/list_creator.dart';
import 'package:game_data/json_decoder.dart';
import 'package:game_data/url_creator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10 Soonest Upcoming Games',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        canvasColor: Colors.white,
      ),
      home: const Scaffold(body: GameDataWidget()),
    );
  }
}

class GameDataWidget extends StatefulWidget {
  const GameDataWidget({super.key});

  @override
  State<GameDataWidget> createState() => _GameDataWidgetState();
}

class _GameDataWidgetState extends State<GameDataWidget> {
  List<Game> upcomingGamesList = [];

  @override
  Widget build(BuildContext context) {
    final widgetList = makeWidgetList();
    return ListView(padding: const EdgeInsets.all(8), children: [
      for (Widget w in widgetList) w,
    ]);
  }

  List<Widget> makeWidgetList() {
    makeUpcomingGameList();

    if (upcomingGamesList.isNotEmpty) {
      return List.generate(
          10,
          (index) => Column(
                children: [
                  Image.network(upcomingGamesList[index].imageUrl),
                  Text(upcomingGamesList[index].title),
                  Text(upcomingGamesList[index].description),
                  Text(upcomingGamesList[index].releaseDate.toString()),
                ],
              ));
    }
    return List.generate(
        1,
        (index) => Column(
              children: const [
                Text('Loading data...'),
              ],
            ));
  }

  Future<void> makeUpcomingGameList() async {
    final gameListCreator = ListCreator();
    final networkAccess = UrlCreator();
    final upcomingGamesUrl = networkAccess.createUpcomingGamesQueryUrl();

    List upcomingSlugs = gameListCreator.createListOfSlugs(
        await JsonDecoder().decodeJsonFromUrl(upcomingGamesUrl));

    List<Game> upcomingGames =
        await gameListCreator.createListOfGames(upcomingSlugs);
    setState(() {
      upcomingGamesList = upcomingGames;
    });
  }
}

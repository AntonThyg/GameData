import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/games_list_creator.dart';
import 'package:game_data/json_parser.dart';
import 'package:game_data/network_access.dart';

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
  final gameListCreator = GameListCreator();
  final networkAccess = NetworkAccess();

  List<Game> upcomingGamesList = [];

  @override
  Widget build(BuildContext context) {
    final widgetList = makeWidgetList();
    return ListView(padding: const EdgeInsets.all(8), children: [
      for (Widget w in widgetList) Expanded(child: w),
    ]);
  }

  List<Widget> makeWidgetList() {
    makeUpcomingGameList();

    return List.generate(
        10,
        (index) => Column(
              children: [
                Image.network(upcomingGamesList[index].imageUrl),
                Text(upcomingGamesList[index].name),
                Text(upcomingGamesList[index].description),
                Text(upcomingGamesList[index].releaseDate.toString()),
              ],
            ));
  }

  Future<void> makeUpcomingGameList() async {
    final gameListCreator = GameListCreator();
    final networkAccess = NetworkAccess();
    final upcomingGamesUrl = networkAccess.queryUpcoming();

    List upcomingSlugs = gameListCreator
        .createListOfSlugs(await JsonParser().parseJson(upcomingGamesUrl));

    List<Game> upcomingGames =
        await gameListCreator.createListOfGames(upcomingSlugs);
    setState(() {
      upcomingGamesList = upcomingGames;
    });
  }
}

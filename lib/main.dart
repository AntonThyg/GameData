import 'package:flutter/material.dart';
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
      title: '10 Soonest Releasing Games',
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

  String imageUrl = '';
  String name = '';
  String description = '';
  String releaseDate = '';
  String rating = '';

  @override
  Widget build(BuildContext context) {
    makeUpcomingGameList();
    return Column(children: [
      Image.network(imageUrl),
      Text(name),
      Text(description),
      Text(releaseDate),
      Text(rating),
    ]);
  }

  Future<void> makeUpcomingGameList() async {
    final gameListCreator = GameListCreator();
    final networkAccess = NetworkAccess();
    final upcomingGamesUrl = networkAccess.queryUpcoming();

    List upcomingSlugs = gameListCreator
        .createListOfSlugs(await JsonParser().parseJson(upcomingGamesUrl));

    List upcomingGamesList =
        await gameListCreator.createListOfGames(upcomingSlugs);

    setState(() {
      imageUrl = upcomingGamesList[1].imageUrl;
      name = upcomingGamesList[1].name;
      description = upcomingGamesList[1].description;
      releaseDate = upcomingGamesList[1].releaseDate.toString();
      rating = upcomingGamesList[1].rating.toString();
    });
  }
}

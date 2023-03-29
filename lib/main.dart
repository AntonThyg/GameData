import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/list_creator.dart';
import 'package:game_data/json_decoder.dart';
import 'package:game_data/url_creator.dart';

import 'game_creator.dart';

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
      title: '10 Soonest Upcoming Games',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        canvasColor: Colors.white60,
      ),
      home: const Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const UpcomingGameDataPage();
        break;
      case 1:
        page = const SearchPage();
        break;
      case 2:
        page = const FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.watch_later_outlined),
                      label: Text('Upcoming'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search),
                      label: Text('Search'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.thumb_up),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white60,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//upcoming games page
class UpcomingGameDataPage extends StatefulWidget {
  const UpcomingGameDataPage({super.key});

  @override
  State<UpcomingGameDataPage> createState() => _UpcomingGameDataPageState();
}

class _UpcomingGameDataPageState extends State<UpcomingGameDataPage> {
  List<Game> upcomingGamesList = [];

  @override
  void initState() {
    if (upcomingGamesList.isEmpty) {
      makeUpcomingGameList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final upcomingGameWidgetList = makeUpcomingWidgetList();
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        for (Widget w in upcomingGameWidgetList) w,
      ],
    );
  }

  List<Widget> makeUpcomingWidgetList() {
    if (upcomingGamesList.isNotEmpty) {
      int i = 10;
      if (upcomingGamesList.length < 10) {
        i = upcomingGamesList.length;
      }
      return List.generate(
        i,
        (index) => Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(upcomingGamesList[index].imageUrl),
                ),
                const SizedBox(
                  width: 20,
                  height: 200,
                  child: null,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 600,
                      height: 20,
                      child: Text(upcomingGamesList[index].title),
                    ),
                    const SizedBox(
                      width: 200,
                      height: 20,
                    ),
                    SizedBox(
                      width: 600,
                      height: 20,
                      child: Text(upcomingGamesList[index].releaseDateString),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        manageFavoriteStatus(upcomingGamesList[index]);
                      },
                      child: const Icon(Icons.thumb_up_sharp),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }
    return List.generate(
      1,
      (index) => Column(children: [
        Image.file(File('images/loading.gif')),
      ]),
    );
  }

  Future<void> makeUpcomingGameList() async {
    final upcomingGamesUrl = urlCreator.createUpcomingGamesQueryUrl();

    List upcomingSlugs = listCreator.createListOfSlugs(
        await jsonDecoder.decodeJsonFromUrl(upcomingGamesUrl));

    List<Game> upcomingGames =
        await listCreator.createListOfGames(upcomingSlugs);
    setState(
      () {
        upcomingGamesList = upcomingGames;
      },
    );
  }

  void manageFavoriteStatus(Game game) {
    switch (favoritesList.contains(game)) {
      case true:
        favoritesList.remove(game);
        break;
      case false:
        favoritesList.add(game);
        break;
    }
  }
}

//search page
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  String search = "";
  Game? game;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Enter the text in the box below.'),
        Row(
          children: [
            SizedBox(
              width: 800,
              child: TextField(
                textAlign: TextAlign.center,
                controller: controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => _searchForGame(),
                  child: const Text('Search')),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _searchForGame() async {
    search = controller.text;
    final gameUrl = urlCreator.createSpecificQueryUrl(search);
    final jsonData = await jsonDecoder.decodeJsonFromUrl(gameUrl);
    setState(() {
      game = gameCreator.createGameFromJson(jsonData);
    });
  }

  Widget displayGame(Game game) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.network(game.imageUrl),
            ),
            const SizedBox(
              width: 20,
              height: 200,
              child: null,
            ),
            Column(
              children: [
                SizedBox(
                  width: 600,
                  height: 20,
                  child: Text(game.title),
                ),
                const SizedBox(
                  width: 200,
                  height: 20,
                ),
                SizedBox(
                  width: 600,
                  height: 20,
                  child: Text(game.releaseDateString),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

//favorites page
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Widget> favoriteWidgetList = [];

  @override
  Widget build(BuildContext context) {
    makeFavoritesList();
    return Column(
      children: [
        for (Widget w in favoriteWidgetList) w,
      ],
    );
  }

  List<Widget> makeFavoritesList() {
    return List.generate(
      favoritesList.length,
      (index) => Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.network(favoritesList[index].imageUrl),
              ),
              const SizedBox(
                width: 20,
                height: 200,
                child: null,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 600,
                    height: 20,
                    child: Text(favoritesList[index].title),
                  ),
                  const SizedBox(
                    width: 200,
                    height: 20,
                  ),
                  SizedBox(
                    width: 600,
                    height: 20,
                    child: Text(favoritesList[index].releaseDateString),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

//cow
class CowWidget extends StatelessWidget {
  const CowWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://media.rawg.io/media/screenshots/c9f/c9f20e71776b841a8b7cf21917a7a15d.jpg',
        ),
      ],
    );
  }
}

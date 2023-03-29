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
        page = const GameDataWidget();
        break;
      case 1:
        page = const SearchPage();
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

class GameDataWidget extends StatefulWidget {
  const GameDataWidget({super.key});

  @override
  State<GameDataWidget> createState() => _GameDataWidgetState();
}

class _GameDataWidgetState extends State<GameDataWidget> {
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
    final widgetList = makeWidgetList();
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        for (Widget w in widgetList) w,
      ],
    );
  }

  List<Widget> makeWidgetList() {
    //makeUpcomingGameList();

    if (upcomingGamesList.isNotEmpty) {
      return List.generate(
        10,
        (index) => Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(upcomingGamesList[index].imageUrl),
                ),
                Column(
                  children: [
                    Text(upcomingGamesList[index].title),
                    Text(upcomingGamesList[index].releaseDate.toString()),
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
      (index) => Column(
        children: const [
          Text('Loading data...'),
        ],
      ),
    );
  }

  Future<void> makeUpcomingGameList() async {
    final listCreator = ListCreator();
    final urlCreator = UrlCreator();
    final upcomingGamesUrl = urlCreator.createUpcomingGamesQueryUrl();

    List upcomingSlugs = listCreator.createListOfSlugs(
        await JsonDecoder().decodeJsonFromUrl(upcomingGamesUrl));

    List<Game> upcomingGames =
        await listCreator.createListOfGames(upcomingSlugs);
    setState(
      () {
        upcomingGamesList = upcomingGames;
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  String search = "";

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
            ElevatedButton(onPressed: () {}, child: const Text('Search')),
            Text(search)
          ],
        ),
      ],
    );
  }

  void _onButtonPressed() {
    setState(
      () {
        search = controller.text;
      },
    );
  }
}

class CowWidget extends StatelessWidget {
  const CowWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
            'https://media.rawg.io/media/screenshots/c9f/c9f20e71776b841a8b7cf21917a7a15d.jpg'),
      ],
    );
  }
}

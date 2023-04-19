import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/main.dart';
import 'package:game_data/widgets/game_page_widget.dart';

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
    if (game == null) {
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
                  onSubmitted: (search) {
                    _searchForGame();
                  },
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
    } else {
      Widget page = GamePage(game!);
      game = null;
      return page;
    }
  }

  Future<void> _searchForGame() async {
    search = controller.text;
    String gameUrl = urlCreator.createSpecificQueryUrl(search);
    var jsonData = await jsonDecoder.decodeJsonFromUrl(gameUrl);

    if (jsonData['redirect'] == true) {
      gameUrl = urlCreator.createSpecificQueryUrl(jsonData['slug']);
      jsonData = await jsonDecoder.decodeJsonFromUrl(gameUrl);
    }

    bool gameIsFavorited = _checkIfGameIsFavorited(jsonData);

    if (!gameIsFavorited) {
      setState(() {
        game = gameCreator.createGameFromJson(jsonData);
      });
    }
  }

  bool _checkIfGameIsFavorited(jsonData) {
    bool gameIsFavorited = false;
    for (Game g in favoritesList) {
      if (jsonData["name"] == g.title) {
        gameIsFavorited = true;
        setState(() {
          game = g;
        });
      }
    }
    return gameIsFavorited;
  }
}

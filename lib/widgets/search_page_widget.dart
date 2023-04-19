import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/game.dart';
import 'package:game_data/game_parser.dart';
import 'package:game_data/json_decoder.dart';
import 'package:game_data/url_creator.dart';
import 'package:game_data/widgets/game_page_widget.dart';

class SearchPage extends StatefulWidget {
  final FavoriteGames favoriteGames;

  const SearchPage({super.key, required this.favoriteGames});

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
      Widget page = GamePage(game!, widget.favoriteGames);
      game = null;
      return page;
    }
  }

  Future<void> _searchForGame() async {
    final urlCreator = UrlCreator();
    final jsonDecoder = JsonDecoder();
    final gameParser = GameParser();
    search = controller.text;
    String gameUrl = urlCreator.createSpecificQueryUrl(search);
    var jsonData = await jsonDecoder.decodeJsonFromUrl(gameUrl);

    if (jsonData['redirect'] == true) {
      gameUrl = urlCreator.createSpecificQueryUrl(jsonData['slug']);
      jsonData = await jsonDecoder.decodeJsonFromUrl(gameUrl);
    }

    setState(() {
      game = gameParser.parse(jsonData);
    });
  }
}

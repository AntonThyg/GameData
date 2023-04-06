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
      Widget page = GamePage().getGamePageWidget(game!);
      game = null;
      return page;
    }
  }

  Future<void> _searchForGame() async {
    search = controller.text;
    final gameUrl = urlCreator.createSpecificQueryUrl(search);
    final jsonData = await jsonDecoder.decodeJsonFromUrl(gameUrl);
    setState(() {
      game = gameCreator.createGameFromJson(jsonData);
    });
  }
}

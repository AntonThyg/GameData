import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/main.dart';

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
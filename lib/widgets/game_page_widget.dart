import 'package:flutter/material.dart';
import 'package:game_data/game_parser.dart';
import '../game.dart';
import '../main.dart';

class GamePage extends StatefulWidget {
  final Game game;

  const GamePage(this.game, {super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameParser gameParser = GameParser();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              child: Image.network(
                widget.game.imageUrl,
                height: 400,
              ),
            ),
          ),
          SizedBox(
            child: Text(
              widget.game.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 35),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              gameParser.getGameReleaseDateString(widget.game.releaseDate),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              'Metacritic rating: ${widget.game.rating}/100',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 400,
            child: Text(
              widget.game.description,
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => manageFavorited(widget.game)),
            child: Icon(favoritesList.contains(widget.game)
                ? Icons.thumb_up
                : Icons.thumb_up_outlined),
          )
        ],
      ),
    );
  }

  void manageFavorited(Game g) {
    if (favoritesList.contains(g)) {
      favoritesList.remove(g);
    } else {
      favoritesList.add(g);
    }
  }
}

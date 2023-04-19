import 'package:flutter/material.dart';

import '../game.dart';

class GamePage extends StatefulWidget {
  final Game game;
  final ElevatedButton favoriteButton;

  const GamePage(this.game, {required this.favoriteButton, super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
              widget.game.releaseDateString,
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
          widget.favoriteButton,
        ],
      ),
    );
  }
}

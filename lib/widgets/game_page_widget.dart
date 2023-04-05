import 'package:flutter/material.dart';

import '../game.dart';

class GamePage extends StatefulWidget {
  Game game;

  GamePage(this.game, {super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.arrow_back_outlined),
        ),
        Container(
          height: 20,
          width: 600,
          color: Colors.grey,
          child: Text(widget.game.title),
        ),
        const SizedBox(
          height: 20,
          child: null,
        ),
        Container(
          height: 20,
          width: 600,
          color: Colors.grey,
          child: Text('${widget.game.rating}'),
        ),
        const SizedBox(
          height: 20,
          child: null,
        ),
        Container(
          color: Colors.grey,
          child: Text(widget.game.description),
        )
      ],
    );
  }
}

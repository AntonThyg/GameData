import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/game_parser.dart';

class GameInListWidget extends StatefulWidget {
  Game game;

  GameInListWidget(this.game, {super.key});

  @override
  State<GameInListWidget> createState() => _GameInListWidgetState();
}

class _GameInListWidgetState extends State<GameInListWidget> {
  GameParser gameParser = GameParser();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: Image.network(widget.game.imageUrl),
        ),
        Column(
          children: [
            SizedBox(
              width: 600,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  widget.game.title,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(
              width: 200,
              height: 10,
            ),
            SizedBox(
              width: 600,
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  gameParser.getGameReleaseDateString(widget.game.releaseDate),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

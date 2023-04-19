import 'package:flutter/material.dart';
import 'package:game_data/game.dart';

class GameWidget extends StatefulWidget {
  final Game game;
  final ElevatedButton favoriteButton;

  const GameWidget({
    super.key,
    required this.game,
    required this.favoriteButton,
  });

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
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
                child: Text(widget.game.releaseDateString),
              ),
            ),
          ],
        )
      ],
    );
  }
}

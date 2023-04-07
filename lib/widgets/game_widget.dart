import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/main.dart';

class GameWidget extends StatefulWidget {
  Game game;

  GameWidget(this.game, {super.key});

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
            ElevatedButton(
              onPressed: () => setState(() => manageFavorited()),
              child: Icon(favoritesList.contains(widget.game)
                  ? Icons.thumb_down
                  : Icons.thumb_up),
            ),
          ],
        )
      ],
    );
  }

  void manageFavorited() {
    switch (favoritesList.contains(widget.game)) {
      case true:
        favoritesList.remove(widget.game);
        break;
      case false:
        favoritesList.add(widget.game);
        break;
    }
  }
}
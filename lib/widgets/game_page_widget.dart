import 'package:flutter/material.dart';

import '../game.dart';

class GamePage {
  Widget getGamePageWidget(Game game) {
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
          child: Text(game.title),
        ),
        const SizedBox(
          height: 20,
          child: null,
        ),
        Container(
          height: 20,
          width: 600,
          color: Colors.grey,
          child: Text('${game.rating}'),
        ),
        const SizedBox(
          height: 20,
          child: null,
        ),
        Container(
          color: Colors.grey,
          child: Text(game.description),
        )
      ],
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

import '../game.dart';

class GamePage {
  Widget getGamePageWidget(Game game) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Icon(Icons.arrow_back_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              child: Image.network(
                game.imageUrl,
                height: 400,
              ),
            ),
          ),
          SizedBox(
            child: Text(
              game.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 35),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              game.releaseDateString,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              'Metacritic rating: ${game.rating}/100',
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
              game.description,
            ),
          )
        ],
      ),
    );
  }
}

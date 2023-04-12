import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/main.dart';

import 'game_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (Game g in favoritesList)
          Row(
            children: [
              GameWidget(g),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    manageFavorited(g);
                  });
                },
                child: Icon(favoritesList.contains(g)
                    ? Icons.thumb_up
                    : Icons.thumb_up_outlined),
              ),
            ],
          ),
      ],
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

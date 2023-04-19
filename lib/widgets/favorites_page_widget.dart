import 'package:flutter/material.dart';
import 'package:game_data/game.dart';
import 'package:game_data/main.dart';

import 'game_in_list_widget.dart';

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
              GameInListWidget(g),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    setFavoritedState(g);
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

  void setFavoritedState(Game g) {
    if (favoritesList.contains(g)) {
      favoritesList.remove(g);
    } else {
      favoritesList.add(g);
    }
  }
}

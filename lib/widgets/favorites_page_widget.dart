import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/game.dart';

import 'game_widget.dart';

class FavoritesPage extends StatefulWidget {
  final FavoriteGames favoriteGames;

  const FavoritesPage({super.key, required this.favoriteGames});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (Game g in widget.favoriteGames.favoritesList.values)
          Row(
            children: [
              GameWidget(
                game: g,
                favoriteButton: widget.favoriteGames.getFavoriteButton(g),
              ),
            ],
          ),
      ],
    );
  }
}

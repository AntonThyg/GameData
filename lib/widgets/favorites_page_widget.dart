import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/game.dart';

import 'game_widget.dart';

class FavoritesPage extends StatefulWidget {
  final FavoriteGames favoriteList;

  const FavoritesPage({super.key, required this.favoriteList});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (Game g in widget.favoriteList.favoritesList.values)
          Row(
            children: [
              GameWidget(
                game: g,
                favoriteButton: ElevatedButton(
                  onPressed: () =>
                      setState(() => widget.favoriteList.setFavoriteState(g)),
                  child: Icon(widget.favoriteList.isFavorited(g)
                      ? Icons.thumb_up
                      : Icons.thumb_up_alt_outlined),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'game.dart';

class FavoriteGames {
  Map<String, Game> favoritesList = {};

  void setFavoriteState(Game game) {
    if (favoritesList.containsKey(game.title)) {
      favoritesList.remove(game.title);
    } else {
      favoritesList.addAll({game.title: game});
    }
  }

  bool isFavorited(Game game) {
    return favoritesList.containsKey(game.title);
  }

  ElevatedButton getFavoriteButton(Game game) {
    return ElevatedButton(
      onPressed: () => setFavoriteState(game),
      child: Icon(isFavorited(game) ? Icons.thumb_up : Icons.thumb_up_outlined),
    );
  }
}

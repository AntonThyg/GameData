import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/upcoming_games.dart';
import 'package:game_data/widgets/game_widget.dart';

import '../game.dart';

class UpcomingGameDataPage extends StatefulWidget {
  final FavoriteGames favoritesList;
  final UpcomingGames upcomingGames;

  const UpcomingGameDataPage(this.upcomingGames, this.favoritesList,
      {super.key});

  @override
  State<UpcomingGameDataPage> createState() => _UpcomingGameDataPageState();
}

class _UpcomingGameDataPageState extends State<UpcomingGameDataPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.upcomingGames.upcomingGamesList.isEmpty) {
      widget.upcomingGames.generate();
      return Column(
        children: [
          Image.asset(
            "images/loading.gif",
            fit: BoxFit.contain,
          ),
        ],
      );
    } else {
      return ListView(
        children: [
          for (Game g in widget.upcomingGames.upcomingGamesList)
            Row(
              children: [
                GameWidget(
                  game: g,
                  favoriteButton: ElevatedButton(
                    onPressed: () => setState(
                        () => widget.favoritesList.setFavoriteState(g)),
                    child: Icon(widget.favoritesList.isFavorited(g)
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
}

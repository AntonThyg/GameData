import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/json_decoder.dart';

import '../game.dart';
import '../upcoming_games.dart';
import '../url_creator.dart';
import 'game_in_list_widget.dart';

class UpcomingGameDataPage extends StatefulWidget {
  final UpcomingGames upcomingGames;
  final FavoriteGames favoriteGames;

  const UpcomingGameDataPage(this.upcomingGames, this.favoriteGames,
      {super.key});

  @override
  State<UpcomingGameDataPage> createState() => _UpcomingGameDataPageState();
}

class _UpcomingGameDataPageState extends State<UpcomingGameDataPage> {
  @override
  void initState() {
    if (widget.upcomingGames.upcomingGamesList.isEmpty) {
      makeUpcomingGameList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upcomingGames.upcomingGamesList.isEmpty) {
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
                        () => widget.favoriteGames.setFavoriteState(g)),
                    child: Icon(widget.favoriteGames.isFavorited(g)
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

  Future<void> makeUpcomingGameList() async {
    final jsonDecoder = JsonDecoder();
    final urlCreator = UrlCreator();
    final upcomingGamesListFetcher = UpcomingGamesListFetcher();
    final upcomingGamesUrl = urlCreator.createUpcomingGamesQueryUrl();

    List upcomingSlugs = upcomingGamesListFetcher.createListOfSlugs(
        await jsonDecoder.decodeJsonFromUrl(upcomingGamesUrl));

    List<Game> upcomingGames =
        await upcomingGamesListFetcher.createListOfGames(upcomingSlugs);
    setState(
      () {
        widget.upcomingGames.upcomingGamesList = upcomingGames;
      },
    );
  }
}

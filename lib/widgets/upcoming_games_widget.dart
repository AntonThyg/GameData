import 'package:flutter/material.dart';
import 'package:game_data/main.dart';
import 'package:game_data/widgets/game_widget.dart';

import '../game.dart';

class UpcomingGameDataPage extends StatefulWidget {
  const UpcomingGameDataPage({super.key});

  @override
  State<UpcomingGameDataPage> createState() => _UpcomingGameDataPageState();
}

class _UpcomingGameDataPageState extends State<UpcomingGameDataPage> {
  @override
  void initState() {
    if (upcomingGamesList.isEmpty) {
      makeUpcomingGameList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (upcomingGamesList.isEmpty) {
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
          for (Game g in upcomingGamesList)
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
  }

  void manageFavorited(Game g) {
    if (favoritesList.contains(g)) {
      favoritesList.remove(g);
    } else {
      favoritesList.add(g);
    }
  }

  Future<void> makeUpcomingGameList() async {
    final upcomingGamesUrl = urlCreator.createUpcomingGamesQueryUrl();

    List upcomingSlugs = listCreator.createListOfSlugs(
        await jsonDecoder.decodeJsonFromUrl(upcomingGamesUrl));

    List<Game> upcomingGames =
        await listCreator.createListOfGames(upcomingSlugs);
    setState(
      () {
        upcomingGamesList = upcomingGames;
      },
    );
  }
}

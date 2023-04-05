import 'dart:io';

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
  List<Game> upcomingGamesList = [];

  @override
  void initState() {
    if (upcomingGamesList.isEmpty) {
      makeUpcomingGameList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final upcomingGameWidgetList = makeUpcomingWidgetList();
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        for (Widget w in upcomingGameWidgetList) w,
      ],
    );
  }

  List<Widget> makeUpcomingWidgetList() {
    if (upcomingGamesList.isNotEmpty) {
      int i = 10;
      if (upcomingGamesList.length < 10) {
        i = upcomingGamesList.length;
      }
      return List.generate(
        i,
        (index) => Column(
          children: [GameWidget(upcomingGamesList[index])],
        ),
      );
    }
    return List.generate(
      1,
      (index) => Column(children: [
        Image.file(File('images/loading.gif')),
      ]),
    );
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

import 'package:flutter/material.dart';
import 'package:game_data/main.dart';
import 'package:game_data/widgets/game_widget.dart';

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
        for (Widget w in makeFavoritesWidgetList()) w,
      ],
    );
  }

  List<Widget> makeFavoritesWidgetList() {
    return List.generate(
      favoritesList.length,
      (index) => Column(
        children: [
          GameWidget(favoritesList[index]),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:game_data/upcoming_games.dart';
import 'package:game_data/widgets/favorites_page_widget.dart';
import 'package:game_data/widgets/page_router.dart';
import 'package:game_data/widgets/search_page_widget.dart';
import 'package:game_data/widgets/upcoming_games_widget.dart';

import 'favorite_games.dart';

void main() {
  final favoriteGames = FavoriteGames();
  final upcomingGames = UpcomingGames();

  final favoritesPage = FavoritesPage(favoriteGames: favoriteGames);
  final upcomingPage = UpcomingGameDataPage(upcomingGames, favoriteGames);
  final searchPage = SearchPage(
    favoriteGames: favoriteGames,
  );

  runApp(
    MyApp(
      favoritesPage: favoritesPage,
      upcomingPage: upcomingPage,
      searchPage: searchPage,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget favoritesPage, searchPage, upcomingPage;

  const MyApp({
    super.key,
    required this.favoritesPage,
    required this.searchPage,
    required this.upcomingPage,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEAS Co.',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        canvasColor: Colors.white60,
      ),
      home: Scaffold(
        body: PageRouter(
          favoritesPage: favoritesPage,
          searchPage: searchPage,
          upcomingPage: upcomingPage,
        ),
      ),
    );
  }
}

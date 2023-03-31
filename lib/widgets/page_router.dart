import 'package:flutter/material.dart';
import 'package:game_data/widgets/cow_widget.dart';
import 'package:game_data/widgets/favorites_page_widget.dart';
import 'package:game_data/widgets/search_page_widget.dart';
import 'package:game_data/widgets/upcoming_games_widget.dart';

class PageRouter extends StatefulWidget {
  const PageRouter({super.key});
  @override
  State<PageRouter> createState() => _PageRouter();
}

class _PageRouter extends State<PageRouter> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const UpcomingGameDataPage();
        break;
      case 1:
        page = const SearchPage();
        break;
      case 2:
        page = const FavoritesPage();
        break;
      case 3:
        page = const CowWidget();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.watch_later_outlined),
                      label: Text('Upcoming'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search),
                      label: Text('Search'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.thumb_up),
                      label: Text('Favorites'),
                    ),
                    NavigationRailDestination(
                      icon: Text(" "),
                      label: Text(" "),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white60,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

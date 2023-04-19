import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_data/widgets/cow_widget.dart';

class PageRouter extends StatefulWidget {
  final Widget favoritesPage, upcomingPage, searchPage;

  const PageRouter(
      {super.key,
      required this.favoritesPage,
      required this.upcomingPage,
      required this.searchPage});

  @override
  State<PageRouter> createState() => _PageRouter();
}

class _PageRouter extends State<PageRouter> {
  bool ignoring = true;
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      _setIgnoringState();
    });

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = widget.upcomingPage;
        break;
      case 1:
        page = widget.searchPage;
        break;
      case 2:
        page = widget.favoritesPage;
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
                child: IgnorePointer(
                  ignoring: ignoring,
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

  void _setIgnoringState() {
    setState(() {
      ignoring = false;
    });
  }
}

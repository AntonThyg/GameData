import 'package:flutter/material.dart';
import 'package:game_data/main.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          Row(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.network(favoritesList[index].imageUrl),
              ),
              const SizedBox(
                width: 20,
                height: 200,
                child: null,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 600,
                    height: 20,
                    child: Text(favoritesList[index].title),
                  ),
                  const SizedBox(
                    width: 200,
                    height: 20,
                  ),
                  SizedBox(
                    width: 600,
                    height: 20,
                    child: Text(favoritesList[index].releaseDateString),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        switch (favoritesList.contains(favoritesList[index])) {
                          case true:
                            favoritesList.remove(favoritesList[index]);
                            break;
                          case false:
                            favoritesList.add(favoritesList[index]);
                            break;
                        }
                      });
                    },
                    child: const Icon(Icons.thumb_up_sharp),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

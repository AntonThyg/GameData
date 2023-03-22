import 'game.dart';

class GameCreator {
  Game createGameFromJson(final jsonData) {
    String name = jsonData["name"];
    String description = jsonData["description"];
    int rating = 0;
    if (jsonData["metacritic"] != null) {
      rating = jsonData["metacritic"];
    }
    DateTime releaseDate = DateTime.parse(jsonData["released"]);
    String imageUrl = '';
    if (jsonData["background_image"] == null) {
      imageUrl =
          'https://t4.ftcdn.net/jpg/02/51/95/53/360_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg';
    } else {
      imageUrl = jsonData["background_image"];
    }
    return Game(name, description, rating, releaseDate, imageUrl);
  }
}

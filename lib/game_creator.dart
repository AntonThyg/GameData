import 'game.dart';

class GameCreator {
  Game createGameFromJson(final jsonData) {
    String name = jsonData["name"];
    String description = jsonData["description"];
    int rating = 0;
    if (jsonData["metacritic"] != null) {
      rating = jsonData["metacritic"];
    }
    DateTime releaseDateISO = DateTime.parse(jsonData["released"]);
    var monthString = getMonthName(releaseDateISO);
    String releaseDateString =
        "$monthString ${releaseDateISO.day.toString()}, ${releaseDateISO.year.toString()}";
    String imageUrl = '';
    if (jsonData["background_image"] == null) {
      imageUrl =
          'https://t4.ftcdn.net/jpg/02/51/95/53/360_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg';
    } else {
      imageUrl = jsonData["background_image"];
    }
    return Game(
        name, description, rating, releaseDateISO, releaseDateString, imageUrl);
  }

  String getMonthName(releaseDateISO) {
    switch (releaseDateISO.month.toString()) {
      case "1":
        return "January";
      case "2":
        return "February";
      case "3":
        return "March";
      case "4":
        return "April";
      case "5":
        return "May";
      case "6":
        return "June";
      case "7":
        return "July";
      case "8":
        return "August";
      case "9":
        return "September";
      case "10":
        return "October";
      case "11":
        return "November";
      case "12":
        return "December";
    }
    return '';
  }
}

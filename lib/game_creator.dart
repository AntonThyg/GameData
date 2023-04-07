import 'package:intl/intl.dart';

import 'game.dart';

class GameCreator {
  Game createGameFromJson(final jsonData) {
    String name = jsonData["name"];
    String description = getGameDescription(jsonData);
    int rating = getGameRating(jsonData);
    String releaseDate = getGameReleaseDate(jsonData);
    String imageUrl = getImageUrl(jsonData);

    return Game(name, description, rating, releaseDate, imageUrl);
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

  int getGameRating(jsonData) {
    if (jsonData["metacritic"] != null) {
      return jsonData["metacritic"];
    } else {
      return 0;
    }
  }

  String getGameReleaseDate(jsonData) {
    if (jsonData["released"] != null) {
      DateTime releaseDateISO = DateTime.parse(jsonData["released"]);
      String monthString = getMonthName(releaseDateISO);
      return "$monthString ${releaseDateISO.day.toString()}, ${releaseDateISO.year.toString()}";
    } else {
      return "Release date not announced";
    }
  }

  String getImageUrl(jsonData) {
    if (jsonData["background_image"] == null) {
      return 'https://t4.ftcdn.net/jpg/02/51/95/53/360_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg';
    } else {
      return jsonData["background_image"];
    }
  }

  String getGameDescription(jsonData) {
    String gameDescription = jsonData["description"];
    gameDescription = gameDescription
        .replaceAll("<p>", "\n\n")
        .replaceAll("</p>", '')
        .replaceAll("<br />", "\n")
        .replaceAll("&quot;", "\"")
        .replaceAll("&apos;", "'")
        .replaceAll("&#39;", "'")
        .replaceAll("&lt;", ">")
        .replaceAll("&gt;", "<")
        .replaceAll("&amp;", "&")
        .trim();

    gameDescription = Bidi.stripHtmlIfNeeded(gameDescription);

    return (gameDescription);
  }
}

class UpcomingGameListCreator {
  List createListOfNames(var parsedJsonData) {
    List listOfGameNames = [];

    final numberOfGames = parsedJsonData['results'].length;
    for (int i = 0; i < numberOfGames; i++) {
      String name = parsedJsonData['results'][i]['name'];
      listOfGameNames.add(name);
    }
    return listOfGameNames;
  }
}

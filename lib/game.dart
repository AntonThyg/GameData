class Game {
  final String title;
  final String description;
  final int rating;
  final DateTime releaseDateISO;
  final String releaseDateString;
  final String imageUrl;

  Game(this.title, this.description, this.rating, this.releaseDateISO,
      this.releaseDateString, this.imageUrl);
}

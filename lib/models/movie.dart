class Movie {
  late int id;
  late String title;
  late DateTime? releaseDate;
  late String posterPath;

  Movie(
      {required this.id,
      required this.title,
      required this.releaseDate,
      required this.posterPath});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? 0 : json['id'].toInt();
    title = json['title'] ?? "";
    releaseDate = json['release_date'] != null
        ? DateTime.tryParse(json['release_date'])
        : null;
    posterPath = json['poster_path'] ?? "";
  }
}

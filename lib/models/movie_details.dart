class MovieDetails {
  late int id;
  late String title;
  late String backdropPath;
  late String posterPath;
  late String overview;
  late double rating;
  late DateTime? releaseDate;
  late Map<String, dynamic>? duration;
  late List<dynamic>? genres;
  late List<dynamic>? genreIds;

  MovieDetails(
      {required this.id,
      required this.title,
      required this.backdropPath,
      required this.posterPath,
      required this.overview,
      required this.rating,
      required this.releaseDate,
      required this.duration,
      required this.genres,
      required this.genreIds});

  MovieDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? 0 : json['id'].toInt();
    title = json['title'] ?? "";
    backdropPath = json['backdrop_path'] ?? "";
    posterPath = json['poster_path'] ?? "";
    overview = json['overview'] ?? "";
    rating =
        json['vote_average'] != null ? json['vote_average'].toDouble() : 0.0;
    releaseDate = json['release_date'] != null
        ? DateTime.tryParse(json['release_date'])
        : null;
    duration = _duration(json['runtime']);
    genres = _extractGenres(json['genres']);
    genreIds = json['genre_ids'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['backdrop_path'] = backdropPath;
    data['poster_path'] = posterPath;
    data['overview'] = overview;
    data['vote_average'] = rating;
    data['release_date'] = releaseDate;
    data['runtime'] = duration;
    data['genres'] = genres;
    data['genre_ids'];
    return data;
  }

  List<dynamic>? _extractGenres(fetchedGanreData) {
    if (fetchedGanreData == null) return null;
    List<dynamic> genresList =
        fetchedGanreData.map((map) => map['name'].toString()).toList();
    return genresList;
  }

  Map<String, int>? _duration(runtime) {
    var duration = runtime == null ? null : Duration(minutes: runtime);
    if (duration == null) {
      return null;
    } else {
      return {
        'hours': duration.inHours,
        'minutes': (duration.inMinutes - duration.inHours * 60)
      };
    }
  }

  factory MovieDetails.fromMap(Map<String, dynamic> map) {
    return MovieDetails(
      id: map['id'],
      title: map['title'],
      backdropPath: map['backdrop_path'],
      posterPath: map['poster_path'],
      overview: map['overview'],
      rating: map['vote_average'],
      releaseDate: DateTime.tryParse(map['release_date']),
      duration: map['runtime'],
      genres: map['genres'],
      genreIds: map['genre_ids'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': rating,
      'release_date': releaseDate?.toIso8601String(),
      'runtime': duration,
      'genres': genres,
      'genre_ids': genreIds,
    };
  }

}

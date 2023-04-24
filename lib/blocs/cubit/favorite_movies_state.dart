part of 'favorite_movies_cubit.dart';

class FavoriteMoviesState {
  List<MovieDetails> favoriteMovies;

  FavoriteMoviesState({
    required this.favoriteMovies
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favoriteMovies': favoriteMovies.map((x) => x.toMap()).toList(),
    };
  }

factory FavoriteMoviesState.fromMap(Map<String, dynamic> map) {
  List<dynamic> favoriteMoviesList = map['favoriteMovies'];
  List<MovieDetails> favoriteMovies = [];

  for (var movie in favoriteMoviesList) {
    MovieDetails movieDetails = MovieDetails.fromMap(movie);
    favoriteMovies.add(movieDetails);
  }

  return FavoriteMoviesState(favoriteMovies: favoriteMovies);
}

  String toJson() => json.encode(toMap());

  factory FavoriteMoviesState.fromJson(String source) => FavoriteMoviesState.fromMap(json.decode(source) as Map<String, dynamic>);
}


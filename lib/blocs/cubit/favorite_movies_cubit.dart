import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'dart:convert';

import '../../models/movie_details.dart';

part 'favorite_movies_state.dart';

class FavoriteMoviesCubit extends HydratedCubit<FavoriteMoviesState> {
  FavoriteMoviesCubit() : super(FavoriteMoviesState(favoriteMovies: []));

  void addToFavorites(MovieDetails movie) {
    var currentListOfFavoriteMovies = state.favoriteMovies;
    currentListOfFavoriteMovies.add(movie);
    emit(FavoriteMoviesState(favoriteMovies: currentListOfFavoriteMovies));
  }

  void removeFromFavorites(MovieDetails movie) {
    var currentListOfFavoriteMovies = state.favoriteMovies;
    var movieToDelete = _findMovie(movie, state.favoriteMovies);
    currentListOfFavoriteMovies.remove(movieToDelete);
    emit(FavoriteMoviesState(favoriteMovies: currentListOfFavoriteMovies));
  }

  MovieDetails? _findMovie(movie, movieList) {
    for (var el in movieList) {
      if (el.id == movie.id) {
        return el;
      }
    }
    return null;
  }

  @override
  FavoriteMoviesState? fromJson(Map<String, dynamic> json) {
    return FavoriteMoviesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoriteMoviesState state) {
    return state.toMap();
  }
}

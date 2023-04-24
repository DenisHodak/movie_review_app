import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_movie_state.dart';

class FavoriteMovieCubit extends Cubit<FavoriteMovieState> {
  FavoriteMovieCubit() : super(FavoriteMovieInitial());

  void checkMovieStatus({movie, movieList}) {
    if (_movieIsInList(movie, movieList)) {
      selectMovieAsFavorite();
    } else {
      unselectMovieAsFavorite();
    }
  }

  void selectMovieAsFavorite (){
    emit(MovieIsFavorite());
  }

  void unselectMovieAsFavorite(){
    emit(MovieIsNotFavorite());
  }
}

bool _movieIsInList(movie, movieList) {
  for (var el in movieList) {
    if (el.id == movie.id) {
      return true;
    }
  }
  return false;
}

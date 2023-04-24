import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/popular_movies_repository.dart';
import '../../models/movie.dart';

part './popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit() : super(PopularMoviesInitial());

  PopularMoviesRepository popularMoviesRepository = PopularMoviesRepository();

  int pageNumber = 1;

  void getPopularMovies() async {
    if (state is PopularMovieInitialLoadInProgress) return;
    if (state is PopularMovieLoadFailed) pageNumber = 1;
    var previouslyLoadedMovies = <Movie>[];
    final currentState = state;
    if (currentState is PopularMoviesLoaded && currentState.reachedLastPage)
      return;
    if (currentState is PopularMoviesLoaded) {
      previouslyLoadedMovies = currentState.popularMovies;
    }

    // Loading
    if (currentState is PopularMoviesInitial ||
        currentState is PopularMovieLoadFailed) {
      emit(PopularMovieInitialLoadInProgress());
    }

    // Api throws an error if page number is more than 500 even there are more pages. 
    if (pageNumber > 500) {
      emit(PopularMoviesLoaded(previouslyLoadedMovies, reachedLastPage: true));
      return;
    }
    try {
      final fetchedMovies =
          await popularMoviesRepository.getPopularMovies(page: pageNumber);
      previouslyLoadedMovies.addAll(fetchedMovies);

      if (fetchedMovies.isNotEmpty) {
        pageNumber++;
        emit(PopularMoviesLoaded(previouslyLoadedMovies));
      } else {
        emit(
            PopularMoviesLoaded(previouslyLoadedMovies, reachedLastPage: true));
      }
    } catch (_) {
      emit(PopularMovieLoadFailed());
    }
  }
}

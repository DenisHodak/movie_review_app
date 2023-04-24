part of 'popular_movies_cubit.dart';

abstract class PopularMoviesState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMovieInitialLoadInProgress extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  PopularMoviesLoaded(this.popularMovies, {this.reachedLastPage=false});

  final List<Movie> popularMovies;
  final bool reachedLastPage;
}

class PopularMovieLoadFailed extends PopularMoviesState {}
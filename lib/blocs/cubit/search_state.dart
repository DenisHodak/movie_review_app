part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResultsLoaded extends SearchState {
  SearchResultsLoaded(this.loadedMovies, {this.reachedLastPage=false});

  final List<MovieDetails> loadedMovies;
  final bool reachedLastPage;
}

class SearchResultsFiltered extends SearchState {
  SearchResultsFiltered(this.loadedMovies, this.filteredMovies, {this.reachedLastPage=false});

  final List<MovieDetails> loadedMovies;
  final List<MovieDetails> filteredMovies;
  final bool reachedLastPage;
}

class SearchResultsLoadFailed extends SearchState {}
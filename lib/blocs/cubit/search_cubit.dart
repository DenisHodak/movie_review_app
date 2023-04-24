import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/search_repository.dart';
import '../../models/movie_details.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  SearchRepository searchRepository = SearchRepository();

  int pageNumber = 1;

  void searchResults(query, {bool initialSearch = false}) async {
    if (query.toString().isEmpty) return; //prevent searching without input
    // every time we press search initialSearch is true
    if (initialSearch) pageNumber = 1;
    if (state is SearchLoading) return;
    var previouslyLoadedMovies = <MovieDetails>[];
    final currentState = state;

    if (currentState is SearchResultsLoaded && !initialSearch) {
      previouslyLoadedMovies = currentState.loadedMovies;
    }

    if (currentState is SearchInitial ||
        currentState is SearchResultsLoadFailed) {
      emit(SearchLoading());
    }
    try {
      final fetchedMovies =
          await searchRepository.searchResults(query: query, page: pageNumber);
      previouslyLoadedMovies.addAll(fetchedMovies);
      if (fetchedMovies.isNotEmpty) {
        pageNumber++;
        emit(SearchResultsLoaded(previouslyLoadedMovies));
      } else {
        emit(
            SearchResultsLoaded(previouslyLoadedMovies, reachedLastPage: true));
      }
    } catch (_) {
      emit(SearchResultsLoadFailed());
    }
  }

  void filterMovies({genreId, year}) {
    var currentState = state;
    List<MovieDetails> movies = [];
    if (currentState is SearchResultsLoaded) {
      movies = currentState.loadedMovies;
    } else if (currentState is SearchResultsFiltered) {
      movies = currentState.loadedMovies;
    } else {
      return;
    }

    var filteredMovies = movies.where((movie) {
      var matchesGenre = genreId == null ||
          (movie.genreIds != null && movie.genreIds!.contains(genreId));
      var matchesYear = year == null ||
          (movie.releaseDate != null &&
              movie.releaseDate != null &&
              movie.releaseDate!.year == year);

      return matchesGenre && matchesYear;
    }).toList();
    // var movies keeps fetched movies
    emit(SearchResultsFiltered(movies, filteredMovies));
  }

  void removeFilters() {
    var currentState = state;
    List<MovieDetails> movies = [];
    if (currentState is SearchResultsFiltered) {
      movies = currentState.loadedMovies;
    } else {
      return;
    }

    emit(SearchResultsLoaded(movies));
  }
}

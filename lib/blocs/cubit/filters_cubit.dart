import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/genres_repository.dart';
import '../../models/genre.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit() : super(FiltersInitial());

  GenresRepository genresRepository = GenresRepository();

  void getGenres() async {
    emit(FiltersLoading());
    try {
      final genres = await genresRepository.getGenres();
      emit(FiltersLoaded(genres));
    } catch (_) {
      emit(FiltersLoadFailed());
    }
  }

  void setGenreFilter(genreId) {
    var currentState = state;
    if (currentState is FiltersLoaded) {
      emit(FiltersLoaded(currentState.genres, selectedGenreId: genreId, selectedYear: currentState.selectedYear));
    } else {
      return;
    }
  }

  void setYearFilter(year) {
    var currentState = state;
    if (currentState is FiltersLoaded) {
      emit(FiltersLoaded(currentState.genres, selectedYear: year, selectedGenreId: currentState.selectedGenreId));
    }
    return;
  }

  void resetFilters() {
    var currentState = state;
    if (currentState is FiltersLoaded) {
      emit(FiltersLoaded(currentState.genres, selectedGenreId: null, selectedYear: null));
    }
    return;
  }
}

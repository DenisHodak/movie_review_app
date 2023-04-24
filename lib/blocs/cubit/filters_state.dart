part of 'filters_cubit.dart';

abstract class FiltersState {}

class FiltersInitial extends FiltersState {}

class FiltersLoading extends FiltersState {}

class FiltersLoaded extends FiltersState {
  FiltersLoaded(this.genres, {this.selectedGenreId, this.selectedYear});


  final List<int> years = List<int>.generate(100, (index) => DateTime.now().year - index);
  final List<Genre> genres;
  final int? selectedGenreId;
  final int? selectedYear;
}

class FiltersLoadFailed extends FiltersState {}

part of 'movie_details_cubit.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  MovieDetailsLoaded(this.movieDetails);

  final MovieDetails movieDetails;
}

class MovieDetailsLoadFailed extends MovieDetailsState {}

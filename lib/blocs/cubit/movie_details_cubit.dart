import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/movie_details_repository.dart';
import '../../models/movie_details.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  MovieDetailsRepository movieDetailsRepository = MovieDetailsRepository();

  void getMovieDetails({required dynamic movieId}) async {
    emit(MovieDetailsLoading());
    try {
      final movieDetails = await movieDetailsRepository.getMovieDetails(movieId: movieId);
      emit(MovieDetailsLoaded(movieDetails));
    } catch (error) {
      emit(MovieDetailsLoadFailed());
    }
  }
}

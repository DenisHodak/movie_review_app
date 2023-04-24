import 'package:dio/dio.dart';

import '../models/movie_details.dart';
import '../config/config.dart';

class MovieDetailsRepository {
  Future<MovieDetails> getMovieDetails({required int movieId}) async {
    try {
      Response response = await Dio().get(Config.movieDetailsUrl(movieId));
      return MovieDetails.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}

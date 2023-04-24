import 'package:dio/dio.dart';

import '../config/config.dart';
import '../models/movie.dart';

class PopularMoviesRepository {
  Future<List<Movie>> getPopularMovies({required int page}) async {
    try {
      Response response = await Dio().get(Config.popularMoviesUrl(page));
      return response.data['results']
          .map<Movie>((json) => Movie.fromJson(json))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}

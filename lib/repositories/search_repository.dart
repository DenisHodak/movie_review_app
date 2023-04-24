import 'package:dio/dio.dart';

import '../models/movie_details.dart';
import '../config/config.dart';

class SearchRepository {
  Future<List<MovieDetails>> searchResults({required int page, query}) async {
    try {
      Response response = await Dio().get(Config.searchUrl(query, page));
      return response.data['results']
          .map<MovieDetails>((json) => MovieDetails.fromJson(json))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}

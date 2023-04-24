import 'package:dio/dio.dart';

import '../models/genre.dart';
import '../config/config.dart';

class GenresRepository {
  Future<List<Genre>> getGenres() async {
    try {
      Response response = await Dio().get(Config.genresUrl);
      return response.data['genres']
          .map<Genre>((json) => Genre.fromJson(json))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}

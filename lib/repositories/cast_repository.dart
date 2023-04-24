import 'package:dio/dio.dart';

import '../models/cast.dart';
import '../config/config.dart';

class CastRepository {
  Future<List<Cast>> getMovieCast({required int movieId}) async {
    try {
      Response response = await Dio().get(Config.movieCastUrl(movieId));
      return response.data['cast']
          .map<Cast>((json) => Cast.fromJson(json))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}

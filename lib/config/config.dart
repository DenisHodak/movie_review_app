import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String baseApiUrl = dotenv.get('BASE_API_URL');
  static String apikey = dotenv.get('API_KEY');
  static String baseImageUrl = dotenv.get('BASE_IMAGE_URL');

  static popularMoviesUrl(int page) => '$baseApiUrl/movie/popular?api_key=$apikey&language=en-US&page=$page';
  static String genresUrl = '$baseApiUrl/genre/movie/list?api_key=$apikey&language=en-US';
  static searchUrl(String query, int page) => '$baseApiUrl/search/movie?api_key=$apikey&include_adult=false&language=en-US&query=$query&page=$page';
  static movieDetailsUrl(int movieId) => '$baseApiUrl/movie/$movieId?api_key=$apikey&language=en-US';
  static movieCastUrl(int movieId) => '$baseApiUrl/movie/$movieId/credits?api_key=$apikey';
  
  static imageUrl (String? imagePath) => '$baseImageUrl$imagePath';
}
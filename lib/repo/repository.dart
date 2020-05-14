import 'package:dio/dio.dart';
import 'package:fluttertmdb/model/video_response.dart';
import '../model/movie_response.dart';

class MovieRepo {
  final String apiKey = "YOUR_KEY_HERE";
  static String mainUrl = "https://api.themoviedb.org/3";

  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/popular';
  var getMovieId = '$mainUrl/movieid/videos';
  var movieUrl = '$mainUrl/movie';

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);

      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/videos",
          queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }
}

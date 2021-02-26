import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../objects/movie.dart';

// allows to be called in other widgets
final movieServiceProvider = Provider<MovieService>((ref) {
  final apiKey = '1234567890';
  return MovieService(apiKey, Dio());
});

class MovieService {
  MovieService(this._apiKey, this._dio);

  final String _apiKey;
  final Dio _dio; 

  Future<List<Movie>> getMovies() async {
    final response = await _dio.get("https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> movies = results.map((movieData) => Movie.fromMap(movieData)).toList(growable: false);

    return movies;
  }
}

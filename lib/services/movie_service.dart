import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';

// allows to be called in other widgets
final movieServiceProvider = Provider<MovieService>((ref) {
  final apiKey = '6578f8355159d1d3f5bf00923aea9cce';
  return MovieService(apiKey, Dio());
});

class MovieService {
  MovieService(this._apiKey, this._dio);

  final String _apiKey;
  final Dio _dio;

  Future<List<Movie>> getPopularMovies() async {
    final response = await _dio.get(
        "https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> popularMovies = results
        .map((movieData) => Movie.fromMap(movieData))
        .toList(growable: false);

    return popularMovies;
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await _dio.get(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> nowPlayingMovies = results
        .map((movieData) => Movie.fromMap(movieData))
        .toList(growable: false);

    return nowPlayingMovies;
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await _dio.get(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> upcomingMovies = results
        .map((movieData) => Movie.fromMap(movieData))
        .toList(growable: false);

    return upcomingMovies;
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await _dio.get(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> topRatedMovies = results
        .map((movieData) => Movie.fromMap(movieData))
        .toList(growable: false);

    return topRatedMovies;
  }
}

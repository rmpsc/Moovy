import 'dart:convert';

class Movie {
  final String title;
  final String posterPath;
  final String overview;
  final double voteAverage;
  final String releaseDate;

  Movie({
    this.title,
    this.posterPath,
    this.overview,
    this.voteAverage,
    this.releaseDate,
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate
    };
  }

  // takes data from api and returns Movie object with that data
  factory Movie.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Movie(
      title: map['title'],
      posterPath: map['poster_path'],
      overview: map['overview'],
      voteAverage: map['vote_average'].toDouble(),
      releaseDate: map['release_date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}

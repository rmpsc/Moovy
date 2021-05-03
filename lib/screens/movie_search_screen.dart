import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:noname/theme.dart';
import 'package:dio/dio.dart';
import 'package:noname/screens/screens.dart';

class MovieSearchScreen extends StatelessWidget {
  MovieSearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
          padding: EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 12.0),
          // Main column
          child: ExamplePage()),
    );
  }
}

class ExamplePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Moovies',);

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: Color(0xff151c26),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      backgroundColor: primaryColor,
      shadowColor: Colors.black,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
        color: secondaryColor,
      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .title
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(
            filteredNames[index].title,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieInfoScreen(movie: filteredNames[index]),
              ),
            );
          },
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Moovies');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('https://randomuser.me/api/?results=100');
    List tempList = new List();

    // List movies = await getPopularMovies();
    // movies = movies + (await getNowPlayingMovies());
    // movies = movies + (await getTopRatedMovies());
    // movies = movies + (await getUpcomingMovies());
    List movies = new List();
    Set<String> movieSet = new Set();

    List popularMovies = await getPopularMovies();
    for (int i = 0; i < popularMovies.length; i++) {
      if (movieSet.add(popularMovies[i].title)) {
        movies.add(popularMovies[i]);
      }
    }
    List nowPlayingMovies = await getNowPlayingMovies();
    for (int i = 0; i < nowPlayingMovies.length; i++) {
      if (movieSet.add(nowPlayingMovies[i].title)) {
        movies.add(nowPlayingMovies[i]);
      }
    }
    List topRatedMovies = await getTopRatedMovies();
    for (int i = 0; i < topRatedMovies.length; i++) {
      if (movieSet.add(topRatedMovies[i].title)) {
        movies.add(topRatedMovies[i]);
      }
    }
    List upcomingMovies = await getUpcomingMovies();
    for (int i = 0; i < upcomingMovies.length; i++) {
      if (movieSet.add(upcomingMovies[i].title)) {
        movies.add(upcomingMovies[i]);
      }
    }

    setState(() {
      names = movies;
      names.shuffle();
      filteredNames = names;
    });
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await dio.get(
        "https://api.themoviedb.org/3/movie/popular?api_key=6578f8355159d1d3f5bf00923aea9cce&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> popularMovies = results
        .map((movieData) => Movie.fromMap(movieData))
        .toList(growable: false);

    return popularMovies;
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await dio.get(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=6578f8355159d1d3f5bf00923aea9cce&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> nowPlayingMovies = results
        .map((movieData) => Movie.fromMap(movieData))
        .toList(growable: false);

    return nowPlayingMovies.reversed.toList();
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await dio.get(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=6578f8355159d1d3f5bf00923aea9cce&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> upcomingMovies = results
        .map((movieData) => Movie.fromMap(movieData))
        .toList(growable: false);

    return upcomingMovies.reversed.toList();
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await dio.get(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=6578f8355159d1d3f5bf00923aea9cce&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    // movieData is variable
    List<Movie> topRatedMovies = results
        .map((movieData) => Movie.fromMap(movieData))
        .toList(growable: false);

    return topRatedMovies.reversed.toList();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:noname/screens/movieList.dart';
import 'package:noname/theme.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:noname/screens/rate_movie_screen.dart';

class MovieInfoScreen extends StatelessWidget {
  final Movie movie;
  MovieInfoScreen({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Stream",
        currentButton: FloatingActionButton(
          heroTag: "stream",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.play_arrow),
          onPressed: () {
            print("Streaming...");
          },
        )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Rate",
        currentButton: FloatingActionButton(
          heroTag: "rate",
          backgroundColor: Colors.yellow,
          mini: true,
          child: Icon(Icons.star),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RateMovie(movie),
              ),
            );
          },
        )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Add",
        currentButton: FloatingActionButton(
          heroTag: "add",
          backgroundColor: Colors.greenAccent,
          mini: true,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteTransition(
                animationType: AnimationType.scale,
                builder: (context) => AddMovie(movie),
              ),
            );
          },
        )));
    return Scaffold(
      backgroundColor: Color(0xff151c26),
      body: Padding(
        padding: EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 12.0),
        // Main column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exit button row
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                icon: Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]),

            // Image row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // Hero widget for movie img animation
                  child: Hero(
                    tag: 'movie-img-${movie.fullImageUrl}',
                    child: Image.network(
                      movie.fullImageUrl,
                      height: 280,
                    ),
                  ),
                ),

                SizedBox(
                  width: 10.0,
                ),

                // Title column
                Expanded(
                  child: Column(
                    children: [
                      // Title
                      AutoSizeText(movie.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                          maxLines: 3,
                          minFontSize: 10,
                          stepGranularity: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center),

                      SizedBox(height: 20),

                      // Release Date
                      Text("Release Date",
                          style: TextStyle(
                              color: Color(0xffF8A99F), fontSize: 17.0),
                          textAlign: TextAlign.center),

                      Text(movie.releaseDate,
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                          textAlign: TextAlign.center),

                      SizedBox(height: 20),

                      // Rating
                      Text("Rating",
                          style: TextStyle(
                              color: Color(0xffF8A99F), fontSize: 17.0),
                          textAlign: TextAlign.center),

                      MaterialButton(
                        onPressed: null,
                        disabledColor: Color(0xffF8A99F),
                        disabledTextColor: Colors.black,
                        child: Text(movie.voteAverage.toString()),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 12.0,
            ),

            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SecondaryText(
                  text: movie.overview,
                )),

            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      floatingActionButton: UnicornDialer(
        hasBackground: false,
        parentButtonBackground: Color(0xffF8A99F),
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.more_horiz),
        childButtons: childButtons,
      ),
    );
  }
}

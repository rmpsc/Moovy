import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MovieInfoScreen extends StatelessWidget {
  final Movie movie;
  MovieInfoScreen({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151c26),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              icon: Icon(Icons.close),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]),
          Row(children: [
            Container(
              child: Image.network(
                movie.smallImageUrl,
                scale: 1.1,
              ),
            ),
            Container(
                child: Expanded(
                    child: Column(children: [
              //Row(children: [

              AutoSizeText(movie.title,
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                  maxLines: 3,
                  minFontSize: 10,
                  stepGranularity: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center),

              //]),
              //Row(children: [
              Text("Release Date",
                  style: TextStyle(color: Colors.orange, fontSize: 17.0),
                  textAlign: TextAlign.center),
              //]),
              //Row(children: [
              Text(movie.releaseDate,
                  style: TextStyle(color: Colors.white, fontSize: 17.0),
                  textAlign: TextAlign.center),
              //]),
              //Row(children: [
              Text("Rating",
                  style: TextStyle(color: Colors.orange, fontSize: 17.0),
                  textAlign: TextAlign.center),
              //]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: null,
                    disabledColor: Colors.yellow,
                    disabledTextColor: Colors.black,
                    child: Text(movie.voteAverage.toString()),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  )
                ],
              )
            ])))
          ]),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(movie.overview,
                        style: TextStyle(color: Colors.white, fontSize: 23.0)),
                  ))),
          new SizedBox(
            height: 100,
            width: 100,
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 50,
              ),
              tooltip: "Add to movie list",
              onPressed: () {},
            ),
          )
        ]),
      ),
    );
  }
}

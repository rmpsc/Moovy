import 'package:flutter/material.dart';
import 'package:noname/models/movie.dart';
import 'package:noname/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateMovie extends StatelessWidget {
  Movie movie;
  RateMovie(Movie movie) {
    this.movie = movie;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      title: PrimaryText(text: "What would you like to rate " + movie.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            movie.fullImageUrl,
            scale: 1.1,
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: SecondaryText(text: "Submit")),
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: SecondaryText(text: "Close")),
      ],
    );
  }
}

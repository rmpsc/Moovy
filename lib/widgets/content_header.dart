import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:noname/screens/screens.dart';
import 'package:noname/widgets/widgets.dart';
import 'package:route_transitions/route_transitions.dart';

class ContentHeader extends StatelessWidget {
  // makes new Content object from content_model.dart
  final List<Movie> featuredContent;

  // constructor
  const ContentHeader({
    Key key,
    this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: 'movie-img-${featuredContent[0].fullImageUrl}',
          child: Container(
            height: 500.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(featuredContent[0].fullImageUrl),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter
              ),
            ),
          ),
        ),
        // makes shadow
        Container(
          height: 500.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.center,
          )),
        ),
        // Sintel title

        /*
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featuredContent.titleImageUrl),
          ),
        ),
        */

        // List and Info
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: 'List',
                onTap: () {
                Navigator.push(
                  context,
                  PageRouteTransition(
                    animationType: AnimationType.scale,
                    builder: (context) => AddMovie(featuredContent[0]),
                  )
                );
              },
              ),
              SizedBox(width: 200.0),
              //_PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'Info',
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieInfoScreen(movie: featuredContent[0]),
                      ),
                    );
                  },
              ),
            ],
          ),
        )
      ],
    );
  }
}

/*
class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
        onPressed: () => print('Trailer'),
        color: Colors.white,
        icon: const Icon(Icons.play_arrow, size: 30.0),
        label: const Text(
          'Trailer',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ));
  }
}
*/
import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:noname/screens/movie_info_screen.dart';
import 'package:noname/theme.dart';
import 'package:route_transitions/route_transitions.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Movie> contentList;
  final bool isTopRated;

  const ContentList({
    Key key,
    @required this.title,
    @required this.contentList,
    this.isTopRated = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: PrimaryText(
              text: title,
            ),
          ),
          Container(
            height: isTopRated ? 320.0 : 220.0,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: contentList.length,
              itemBuilder: (BuildContext context, int index) {
                final Movie content = contentList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteTransition(
                        animationType: AnimationType.fade,
                        builder: (context) =>
                            MovieInfoScreen(movie: contentList[index]),
                      ),
                    );
                  },
                  child: Stack(children: [
                  // Hero widget for movie img animation
                   Hero(
                    tag: 'movie-img-${content.fullImageUrl}',
                    child: Container(
                      height: isTopRated ? 400.0 : 200.0,
                      width: isTopRated ? 200.0 : 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(content.fullImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                    Positioned(top:0,child:(MaterialButton(  
                        minWidth: 2.0,
                        height: 5.0,
                        onPressed: null,
                        disabledColor: Color(0xffF8A99F),
                        disabledTextColor: Colors.black,
                        child: Text(content.voteAverage.toString()),
                        padding: EdgeInsets.all(10),
                        shape: CircleBorder(),
                      )))                      ,
                  ],)
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

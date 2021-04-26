import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noname/screens/screens.dart';
import 'package:noname/screens/settings.dart';
import 'package:noname/screens/movieList.dart';
import 'package:noname/screens/movie_search_screen.dart';
import 'package:noname/theme.dart';
import 'package:route_transitions/route_transitions.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 12.0,
      ),
      //color: Color(0xff151c26),
      color: Color(0xff151c26),
      child: Row(
        children: [
          Image.asset(
            'assets/tr_moovy_logo2.gif',
            height: 50,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                    title: 'Moovies',
                    onTap: () => Navigator.of(context).pushReplacement(
                        PageRouteTransition(
                            animationType: AnimationType.fade,
                            builder: (BuildContext context) => Home()))),
                _AppBarButton(
                    title: 'My List',
                    onTap: () => Navigator.of(context).pushReplacement(
                        PageRouteTransition(
                            animationType: AnimationType.fade,
                            builder: (BuildContext context) => MovieList()))),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (BuildContext context) => SettingsPage()));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MovieSearchScreen(),
                    ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// underscore makes class private
// in this case, we're only using this class in custom_app_bar hence the "_"
class _AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const _AppBarButton({
    Key key,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SecondaryText(text: title),
    );
  }
}

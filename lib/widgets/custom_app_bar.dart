import 'package:flutter/material.dart';
import 'package:noname/screens/settings.dart';
import 'package:noname/screens/movieList.dart';

class CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 20.0,
      ),
      //color: Color(0xff151c26),
      color: Color(0xff151c26),
      child: Row(
        children: [
          Image.asset('assets/tr_moovy_logo2.gif', height: 50,),
          const SizedBox(width: 12.0,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: 'Moovies', onTap: () => print('Moovies'),),
                _AppBarButton(title: 'My List', onTap: () => {Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MovieList()))},),
                _AppBarButton(title: 'Account', onTap: () => print('Account'),),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SettingsPage()));
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
      onTap: () => onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

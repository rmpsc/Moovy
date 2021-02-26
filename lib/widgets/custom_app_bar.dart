import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 30.0,
        horizontal: 20.0,
      ),
      color: Colors.black,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _AppBarButton(title: 'Moovies', onTap: () => print('Moovies'),),
            _AppBarButton(title: 'My List', onTap: () => print('My List'),),
            _AppBarButton(title: 'Account', onTap: () => print('Account'),),
          ],
        ),
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

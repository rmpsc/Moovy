import 'dart:ui';
import 'package:flutter/material.dart';

Color primaryColor = Color(0xff151c26);
Color secondaryColor = Color(0xffF8A99F);

class PrimaryText extends StatelessWidget {
  final String text;

  const PrimaryText({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SecondaryText extends StatelessWidget {
  final String text;

  const SecondaryText({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:noname/pages/login.dart';
import 'package:noname/pages/home.dart';
import 'package:noname/pages/account.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/home': (context) => Home(),
      '/account': (context) => Account(),
    }
));

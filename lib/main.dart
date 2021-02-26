import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'screens/screens.dart';

void main() {
  runApp(ProviderScope(child: Moovy()));
}

class Moovy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moovy',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
        '/account': (context) => Account(),
      }
    );
  }
}

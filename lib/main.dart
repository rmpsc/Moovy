import 'package:flutter/material.dart';
import 'package:noname/screens/wrapper.dart';
import 'package:noname/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:noname/models/user.dart';
void main() => runApp(MyApp());

    // initialRoute: '/',
    // routes: {
    //   '/': (context) => Login(),
    //   '/home': (context) => Home(),
    //   '/account': (context) => Account(),
    //   '/register': (context) => Register(),
    // }
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

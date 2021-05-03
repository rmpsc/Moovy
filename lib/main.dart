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
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/home': (context) => Home(),
          '/account': (context) => Account2(),
        });
  }
}


/* import 'package:flutter/material.dart';
import 'package:noname/screens/screens.dart';
import 'package:noname/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:noname/models/user.dart';
import 'package:flutter_riverpod/all.dart';
void main() {
  runApp(ProviderScope(child: Moovy()));
}

class Moovy extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moovy',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
        routes: {
          '/': (context) => AuthService()
          '/home': (context) => Home(),
          '/account': (context) => Account2(),
        });
    )
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
 */
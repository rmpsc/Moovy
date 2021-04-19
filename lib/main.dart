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
      }
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:noname/screens/wrapper.dart';
// import 'package:noname/services/auth.dart';
// import 'package:provider/provider.dart';
// import 'package:noname/models/user.dart';
// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<User>.value(
//       value: AuthService().user,
//       child: MaterialApp(
//         home: Wrapper(),
//       ),
//     );
//   }
// }

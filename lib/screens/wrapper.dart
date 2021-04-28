import 'package:flutter/material.dart';
import 'package:noname/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:noname/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      print("signed in");
      return Home1();
    }
  }
}
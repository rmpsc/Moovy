import 'package:flutter/material.dart';
import 'package:noname/pages/authenticate/login.dart';
import 'package:noname/pages/authenticate/reg.dart';
import 'package:noname/pages/home.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleView: toggleView);
    }
    else{
      return Reg(toggleView: toggleView);
    }
  }
}
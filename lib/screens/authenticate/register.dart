import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.black,
        title: const Text('Sign Up',
          style: TextStyle(
          color: Color(0xffF8A99F),
          fontFamily: 'Montserrat'
          )
        ),
      centerTitle: true,
      elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        ),
      ),
    );
  }
}

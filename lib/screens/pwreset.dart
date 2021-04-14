import 'package:flutter/material.dart';
import 'package:noname/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';

class pwreset extends StatefulWidget {
  static String id = 'password-reset';
  final String message =
      "A unique link has been sent to your email. Please click the link and reset your password.";

  @override
  _pwreset createState() => _pwreset();
}

class _pwreset extends State<pwreset> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String _email;

  _passwordReset() async {
    try {
      _formKey.currentState.save();
      final user = await _auth.sendPasswordResetEmail(email: _email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ConfirmEmail(
            message: widget.message,
          );
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              TextFormField(
                onSaved: (newEmail) {
                  _email = newEmail;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.email_rounded,
                    color: Colors.white,
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Send Email'),
                onPressed: () {
                  _passwordReset();
                  print(_email);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

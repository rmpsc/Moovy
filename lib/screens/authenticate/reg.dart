import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noname/screens/authenticate/login.dart';
import 'package:noname/screens/authenticate/register.dart';
import 'package:noname/screens/home.dart';
import 'package:noname/screens/pwreset.dart';
import 'package:noname/services/auth.dart';
import 'package:noname/services/database.dart';
import 'package:noname/models/user.dart';

class Reg extends StatefulWidget {
  //Reg({Key key, this.title}) : super(key: key);
  //final String title;

  final Function toggleView;
  Reg({this.toggleView});

  @override
  _RegState createState() => _RegState();
}

class _RegState extends State<Reg> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';
  String userLocation = '';
  String err = "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null, null)";


  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        validator: (val) => val.isEmpty  ? "Enter an email" : null,
        //key: _formKey,
        onChanged: (val) {
          setState(() => email = val);
        },
        obscureText: false,
        style: new TextStyle(fontSize: 22.0, color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail, color: Colors.white),
            //prefix: Icon(Icons.mail_outline),
            enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Colors.white, width: 3.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffB4FA92), width: 3.0),
                borderRadius: BorderRadius.circular(32)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "john@example.com",
            fillColor: Color(0xffF8A99F),
            filled: true));
    final passwordField = TextFormField(
      validator: (val) => val.length < 6 ? "Enter a password longer than 6 character" : null,
      //key: _formKey,
      onChanged: (val) {
        setState(() => password = val);
      },
      obscureText: true,
      style: new TextStyle(fontSize: 22.0, color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: Colors.white, width: 3.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB4FA92), width: 3.0),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        fillColor: Color(0xffF8A99F),
        filled: true,
      ),
    );
    final location = TextFormField(
      validator: (val) => val.length == 0 ? "Location can not be blank" : null,
      //key: _formKey,
      obscureText: false,
      onChanged: (val) {
        setState(() => userLocation = val);
      },
      style: new TextStyle(fontSize: 22.0, color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: Colors.white, width: 3.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB4FA92), width: 3.0),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Location",
        fillColor: Color(0xffF8A99F),
        filled: true,
      ),
    );
    final fN = TextFormField(
      validator: (val) => val.length == 0 ? "First Name can not be blank" : null,
      //key: _formKey,
      obscureText: false,
      onChanged: (val) {
        setState(() => firstName = val);
      },
      style: new TextStyle(fontSize: 22.0, color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: Colors.white, width: 3.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB4FA92), width: 3.0),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "First Name",
        fillColor: Color(0xffF8A99F),
        filled: true,
      ),
    );
    final lN = TextFormField(
      validator: (val) => val.length == 0 ? "Last Name can not be blank" : null,
      obscureText: false,
      onChanged: (val) {
        setState(() => lastName = val);
      },
      style: new TextStyle(fontSize: 22.0, color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: Colors.white, width: 3.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB4FA92), width: 3.0),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Last Name",
        fillColor: Color(0xffF8A99F),
        filled: true,
      ),
    );
    final regButon = Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
        child: Ink(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4.0),
              borderRadius: BorderRadius.circular(32)),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              if(_formKey.currentState.validate()){
                dynamic result = await _auth.registerWithEmailandPassword(email, password,firstName,lastName,userLocation);
                

                if (result == null){
                  setState(() => error = 'Invalid email');
                }
                else if (result == err) {
                  setState(() => error = 'Email already in use');
                }
              }
            },

            child: Text("Register",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));


    final fgtpw = Container(
      height: 20,
      width: 128,
      color: Colors.black,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pwreset()));
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          )),
    );

    final signIn = Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: 40,
        width: 300,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Text("Already have an account?",
                    style: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.white))),
            SizedBox(width: 5),
            Center(
              child: InkWell(
                  onTap: () {
                    //Navigator.push(
                    //context, MaterialPageRoute(builder: (context) => Register()));
                    widget.toggleView();
                  },
                  child: Text(
                    "Sign in!",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xffF8A99F),
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ));

    final userInput = Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            emailField,
            SizedBox(height: 10.0),
            passwordField,
            SizedBox(height: 10.0,),
            fN,
            SizedBox(height: 10.0,),
            lN,
            SizedBox(height: 10.0,),
            location,
          ]
        )
      ),
    );

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        //key:  _formKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/moovybackground.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(36, 36, 36, 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                SizedBox(
                  height: 150.0,
                  child: Image.asset(
                    "assets/moovylogo.png",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 40.0),
                userInput,
                
                //fgtpw,
                SizedBox(
                  height: 20.0,
                ),
                regButon,
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: TextStyle( 
                    color: Colors.red,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    )
                  
                ),
                SizedBox(
                  height: 20.0,
                ),
                signIn
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

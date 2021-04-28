import 'package:flutter/material.dart';
import 'package:noname/models/user.dart';
import 'package:noname/services/auth.dart';
import 'package:provider/provider.dart';

class ManageEmail extends StatefulWidget {
  @override
  _ManageEmailState createState() => _ManageEmailState();
}

class _ManageEmailState extends State<ManageEmail> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool checkCurrentEmailAndPasswordValid = false;
  String currentEmail;
  String pw;
  String repw;
  String error = '';
  String error1 = '';
  String newEmail;
  bool same = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final passwordField = TextFormField(
        onChanged: (val) {
          setState(() => pw = val);
        },
        //validator: (val) => checkCurrentEmailAndPasswordValid == false ? "Incorrect email/password" : null,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all(12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink, width: 2.0),
            ),
            hintText: "Enter current password"));
    final repasswordField = TextFormField(
        onChanged: (val) {
          setState(() => repw = val);
        },
          validator: (val) {
          return pw == val ? null : "Passwords do not match";
        },        obscureText: true,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all(12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink, width: 2.0),
            ),
            hintText: "Re-enter password"));

    final newEmailField = TextFormField(
        onChanged: (val) {
          setState(() => newEmail = val);
        },
        
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all(12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink, width: 2.0),
            ),
            hintText: "Enter new email"));

    final changeEmailBtn = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
      ),
      child: Text(
        'Change Email',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        
        checkCurrentEmailAndPasswordValid = await _auth.validatePassword(pw);
        print(checkCurrentEmailAndPasswordValid);
        if (checkCurrentEmailAndPasswordValid == false){
                  setState(() => error1 = 'Invalid password');
        }
        else if (_formKey.currentState.validate() && checkCurrentEmailAndPasswordValid) {
          setState(() => error1 = '');
          dynamic result = await _auth.updateUserEmail(newEmail);
          print(result);
          print("here");
          print(result==false);
          if (result == false){
                  setState(() => error = 'Invalid new email');
                }
          else if(result == true){
            Navigator.pop(context);
          }
        }
      },
    );

    final userInput = Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                passwordField,
                SizedBox(height: 10),
                //repasswordField,
                Text(
                  error1,
                  style: TextStyle( 
                    color: Colors.red,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    )
                  
                ),
                SizedBox(height: 10),
                newEmailField,
                Text(
                  error,
                  style: TextStyle( 
                    color: Colors.red,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    )
                  
                )
              ],
            )));

    return Scaffold(
        appBar: AppBar(
          title: Text('Manage Email'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(36, 36, 36, 45),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          userInput,
                          SizedBox(height: 10),
                          changeEmailBtn
                        ])))));
  }
}

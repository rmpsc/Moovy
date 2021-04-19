import 'package:flutter/material.dart';
import 'package:noname/models/user.dart';
import 'package:noname/services/auth.dart';
import 'package:provider/provider.dart';

class ManagePassword extends StatefulWidget {
  @override
  _ManagePasswordState createState() => _ManagePasswordState();
}

class _ManagePasswordState extends State<ManagePassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid = true;
  String currentpw;
  String newpw;
  String renewpw;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final currentPasswordField = TextFormField(
        onChanged: (val) {
          setState(() => currentpw = val);
        },
        obscureText: true,
        decoration: InputDecoration(
          errorText: checkCurrentPasswordValid
            ? null : "Incorrect Password",
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all(12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink, width: 2.0),
            ),
            hintText: "Password"));
    final newPasswordField = TextFormField(
        onChanged: (val) {
          setState(() => newpw = val);
        },
        obscureText: true,
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
            hintText: "New Password"));

    final reNewPasswordField = TextFormField(
        onChanged: (val) {
          setState(() => renewpw = val);
        },
        obscureText: true,
        validator: (val) {
          return newpw == val ? null : "Passwords do not match";
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
            hintText: "Re-enter New Password"));

    final changePasswordBtn = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
      ),
      child: Text(
        'Change Password',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        print(currentpw);
        checkCurrentPasswordValid =await _auth.validatePassword(currentpw);

        print(checkCurrentPasswordValid);

        if (_formKey.currentState.validate()) {
          
          Navigator.pop(context);
        }
      },
    );

    final userInput = Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                currentPasswordField,
                SizedBox(height: 10),
                newPasswordField,
                SizedBox(height: 10),
                reNewPasswordField,
              ],
            )));

    return Scaffold(
        appBar: AppBar(
          title: Text('Manage Password'),
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
                          changePasswordBtn
                        ])))));
  }
}

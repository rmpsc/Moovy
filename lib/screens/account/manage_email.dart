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
  String currentEmail;
  String pw;
  String newEmail;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final currentPasswordField = TextFormField(
        onChanged: (val) {
          setState(() => currentEmail = val);
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
            hintText: "Enter current email"));
    final newPasswordField = TextFormField(
        onChanged: (val) {
          setState(() => pw = val);
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
            hintText: "Enter Password"));

    final reNewPasswordField = TextFormField(
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

    final changePasswordBtn = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
      ),
      child: Text(
        'Change Email',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        print(_formKey.currentState);
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
                          changePasswordBtn
                        ])))));
  }
}

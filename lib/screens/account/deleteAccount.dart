import 'package:flutter/material.dart';
import 'package:noname/models/user.dart';
import 'package:noname/screens/account/userAccount.dart';
import 'package:noname/screens/authenticate/login.dart';
import 'package:noname/services/auth.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final EmailField = TextFormField(
        onChanged: (val) {
          setState(() => email = val);
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
    final PasswordField = TextFormField(
        onChanged: (val) {
          setState(() => password = val);
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

    final deleteBtn = ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
                      ),
                      child: Text(
                        'Delete Account',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print(email);
                        print(password);
                        
                        await AuthService().deleteUser(email, password);
                        Navigator.push(
                            //context, MaterialPageRoute(builder: (context) => userAccount(user: user)));
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()));
                      },
                    );

    final userInput = Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                EmailField,
                SizedBox(height: 10),
                PasswordField,
                SizedBox(height: 10)
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
                          deleteBtn
                        ])))));
  }
}

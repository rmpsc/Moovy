import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:noname/screens/screens.dart';
import 'package:noname/services/services.dart';
import 'package:provider/provider.dart';

class userAccount extends StatefulWidget {
  //final User user;

  //userAccount({Key key, @required this.user}) : super(key: key);

  @override
  _userAccountState createState() => _userAccountState();
}

class _userAccountState extends State<userAccount> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  String _currentFirstName;
  String _currentLastName;
  String _currentLocation;
  String email;
  String password;
  String currentpw;
  String newpw;
  String renewpw;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('User Acount'),
          backgroundColor: Colors.black,
        ),
        key: _scaffoldKey,
        body: ListView(
          padding: EdgeInsets.fromLTRB(50, 150, 50, 0),
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
              ),
              child: Text(
                'View/Update Profile',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Navigator.push(
                    //context, MaterialPageRoute(builder: (context) => userAccount(user: user)));
                    context,
                    MaterialPageRoute(builder: (context) => ManageProfile()));
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
              ),
              child: Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                // print(_formKey.currentState);
                // if (_formKey.currentState.validate()) {
                //   Navigator.pop(context);
                // }
                Navigator.push(
                    //context, MaterialPageRoute(builder: (context) => userAccount(user: user)));
                    context,
                    MaterialPageRoute(builder: (context) => ManagePassword()));
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
              ),
              child: Text(
                'Change Email',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Navigator.push(
                    //context, MaterialPageRoute(builder: (context) => userAccount(user: user)));
                    context,
                    MaterialPageRoute(builder: (context) => ManageEmail()));
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
              ),
              child: Text(
                'Delete Account',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Navigator.push(
                    //context, MaterialPageRoute(builder: (context) => userAccount(user: user)));
                    context,
                    MaterialPageRoute(builder: (context) => DeleteAccount()));
              },
            ),
          ],
        ));
  }
}

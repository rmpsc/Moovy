import 'package:flutter/material.dart';
import 'package:noname/services/auth.dart';

class Home2 extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home2> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Moovy'),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white,
              //backgroundColor: Color(0xffF8A99F),
            ),
            icon: Icon(Icons.person),
            label: Text("logout"),
            onPressed: () async {
               await _auth.signOut();
                //Navigator.push(
                  //context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:noname/screens/account.dart';
import 'package:noname/screens/authenticate/login.dart';
import 'package:noname/services/auth.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();


  

  @override
  Widget build(BuildContext context) {
    final userProfile = Container(
      height: 20,
      width: 85,
      color: Colors.black,
      child: InkWell(
        onTap: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Account()));
        },
        child: Text("User Profile",
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline
        ),)
      ),
    );

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
      ),
      body: Center(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[userProfile],)
      )
    );
  }
}

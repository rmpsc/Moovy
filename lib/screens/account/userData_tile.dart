import 'package:flutter/material.dart';
import 'package:noname/models/user.dart';
import 'package:noname/models/userData.dart';

class UserTile extends StatelessWidget {

  final UserData user;
  UserTile({this.user});

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Color(0xffF8A99F),
          ),
          title: Text(user.firstName + " " + user.lastName),
          subtitle: Text(user.location),
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noname/models/userData.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {


    final users = Provider.of<List<UserData>>(context);
    //print(users);
    // for (var doc in users.documents){
    //   print(doc.data);
    // }
    users.forEach((user){
      print(user.firstName);
      print(user.lastName);
      print(user.location);
    });
    return Container(
      
    );
  }
}
import 'package:flutter/material.dart';
import 'package:noname/models/userData.dart';
import 'package:noname/services/database.dart';
import 'package:provider/provider.dart';
import 'package:noname/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noname/pages/user_list.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('User Acount'),
          backgroundColor: Colors.black,
        ),
        body: UserList(),
      )
    );
  }
}

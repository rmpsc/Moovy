import 'package:flutter/material.dart';
import 'package:noname/models/user.dart';
import 'package:noname/models/userData.dart';
import 'package:noname/screens/account/settings_form.dart';
import 'package:noname/services/database.dart';
import 'package:provider/provider.dart';
import 'package:noname/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noname/screens/account/user_list.dart';
import 'package:noname/screens/home.dart';

class Account extends StatefulWidget {
  final User user;

  Account({Key key, @required this.user}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context, 
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: SettingsForm(user: user),
          );
        }
        );
    }


    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('User Acount'),
          backgroundColor: Colors.black,
          actions: <Widget>[
            TextButton.icon(
              style: TextButton.styleFrom(
              primary: Colors.white,
              ),
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
              )
          ]
        ),
        body: UserList(),
      )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:noname/services/services.dart';
import 'package:noname/screens/screens.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    final users = Provider.of<List<UserData>>(context) ?? [];
    //print(users);
    // for (var doc in users.documents){
    //   print(doc.data);
    // }
    int idx;
    _auth.getCurrentUID().then((userid) {
      int count = 0;

      users.forEach((user) {
        if (userid == user.uid) {
          print(user.uid);
          print(user.firstName);
          print(user.lastName);
          print(user.location);
          idx = count;
          print(idx);
        }
        count++;
      });
    });
    // users.forEach((user){
    //   if(_auth.getCurrentUID()==user.uid)
    //   {
    //     print(user.uid);
    //     print(user.firstName);
    //     print(user.lastName);
    //     print(user.location);
    //   }
    // });
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return UserTile(user: users[2]);
      },
    );
  }
}

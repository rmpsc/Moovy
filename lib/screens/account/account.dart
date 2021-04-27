import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:noname/screens/screens.dart';
import 'package:noname/services/services.dart';
import 'package:provider/provider.dart';

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
          });
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
              ]),
          body: UserList(),
        ));
  }
}

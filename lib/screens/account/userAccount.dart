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
import 'package:noname/shared/constants.dart';

class userAccount extends StatefulWidget {
  final User user;

  userAccount({Key key, @required this.user}) : super(key: key);

  @override
  _userAccountState createState() => _userAccountState();
}

class _userAccountState extends State<userAccount> {

  final _formKey = GlobalKey<FormState>();
  String _currentFirstName;
  String _currentLastName;
  String _currentLocation;



  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).usersData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Scaffold(
            key: _formKey,
            body: ListView(
              padding: EdgeInsets.all(50),
              children: <Widget>[
                Text('Update your account settings.',
                style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                Text('First Name'),
                TextFormField(
                  initialValue: userData.firstName,
                  decoration: textInputDecoration,
                  validator: (val)=> val.isEmpty ? 'Please enter your first name' : null,
                  onChanged: (val) => setState(() => _currentFirstName = val),
                ),
                SizedBox(height: 20),
                Text('Last Name'),
                TextFormField(
                  initialValue: userData.lastName,
                  decoration: textInputDecoration,
                  validator: (val)=> val.isEmpty ? 'Please enter your last name' : null,
                  onChanged: (val) => setState(() => _currentLastName = val),
                ),
                SizedBox(height: 20),
                Text('Location'),
                TextFormField(
                  initialValue: userData.location,
                  decoration: textInputDecoration,
                  validator: (val)=> val.isEmpty ? 'Please enter your location' : null,
                  onChanged: (val) => setState(() => _currentLocation = val),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentFirstName ?? userData.firstName, 
                        _currentLastName ?? userData.lastName, 
                        _currentLocation ?? userData.location
                        );
                        Navigator.pop(context);
                    }
                  }, 
                  )
              ],
            )
          
        );

        }else {
          return null;
        }

        
      }
    );
  }
}
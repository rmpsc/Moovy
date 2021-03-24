import 'package:flutter/material.dart';
import 'package:noname/models/user.dart';
import 'package:noname/models/userData.dart';
import 'package:noname/services/database.dart';
import 'package:noname/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  final User user;

  SettingsForm({Key key, @required this.user}) : super(key: key);
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

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

          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Text('Update your account settings.',
                style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.firstName,
                  decoration: textInputDecoration,
                  validator: (val)=> val.isEmpty ? 'Please enter your first name' : null,
                  onChanged: (val) => setState(() => _currentFirstName = val),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.lastName,
                  decoration: textInputDecoration,
                  validator: (val)=> val.isEmpty ? 'Please enter your last name' : null,
                  onChanged: (val) => setState(() => _currentLastName = val),
                ),
                SizedBox(height: 20),
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
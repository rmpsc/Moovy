import 'package:flutter/material.dart';
import 'package:noname/models/user.dart';
import 'package:noname/screens/account/userAccount.dart';
import 'package:noname/screens/authenticate/authenticate.dart';
import 'package:noname/screens/authenticate/login.dart';
import 'package:noname/screens/wrapper.dart';
import 'package:noname/services/auth.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool checkPasswordValid = false;
  String password;
  String repassword;
  String err = '';
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final passwordField = TextFormField(
        onChanged: (val) {
          setState(() => password = val);
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all(12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink, width: 2.0),
            ),
            hintText: "Enter current password"));
    final repasswordField = TextFormField(
        onChanged: (val) {
          setState(() => repassword = val);
        },
        // validator: (val) {
        //   return repassword == val ? null : "Passwords do not match";
        // },
        obscureText: true,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all(12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink, width: 2.0),
            ),
            hintText: "Re-enter Password"));

    final check = CheckboxListTile(
      title: Text("Are you sure you want to delete your account?",
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      activeColor: Color(0xffF8A99F),
      value: checkValue, 
      onChanged: (val){
        setState(() {
          checkValue = val;
        });
      }
    );


    final deleteBtn = ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffF8A99F)),
                      ),
                      child: Text(
                        'Delete Account',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print(password);
                        checkPasswordValid = await _auth.validatePassword(password);

                        if(password != repassword){
                          setState(() => err = 'Passwords do not match');
                        }
                        else if(password == repassword){
                          setState(() => err = '');
                           if(checkPasswordValid == false){
                          setState(() => err = 'Incorrect password');
                          }
                          else if(_formKey.currentState.validate() && checkPasswordValid && checkValue){
                          await AuthService().deleteUser();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            Wrapper()), (Route<dynamic> route) => false);
                          
                        }
                        }
                        // Navigator.push(
                        //     //context, MaterialPageRoute(builder: (context) => userAccount(user: user)));
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Login()));
                      },
                    );

    final userInput = Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                passwordField,
                SizedBox(height: 10),
                repasswordField,
                Text(
                  err,
                  style: TextStyle( 
                    color: Colors.red,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    )
                  
                ),
                SizedBox(height: 10)
              ],
            )));

    return Scaffold(
        appBar: AppBar(
          title: Text('Delete Account'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(36, 36, 36, 45),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          userInput,
                          
                          SizedBox(height: 10),
                          check,
                          deleteBtn
                        ])))));
  }
}

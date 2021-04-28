
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noname/models/user.dart';
import 'package:noname/screens/authenticate/authenticate.dart';
import 'package:noname/screens/wrapper.dart';
import 'package:noname/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String err1 = "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null, null)";
  String err2 = "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null, null)";
  
  //create user object based on Firebaseuser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }


  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user));
      //.map(_userFromFirebaseUser);
  }


  //sign in anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } 
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser()).uid;
  }

  //sign in with email and pw
  Future signInWithEmailandPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } 
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email and pw
  Future registerWithEmailandPassword(String email, String password, String firstName, String lastName, String location) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      

      //create a new document from the user with uid
      await DatabaseService(uid: user.uid).updateUserData(firstName,lastName,location);

      return _userFromFirebaseUser(user);
    } 
    catch(e){
      print(e.toString());
      if (e.toString() == err1 ){
        return err1;
      }
      else{
        
      return null;
      }
    }
  }


  //sign out

  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  
  //delete user
  Future deleteUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      print(user);
      print(user.uid);
      await DatabaseService(uid: user.uid).deleteuser(); // called from database class
      await user.delete();
      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> validatePassword(String password) async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    
    String pw = password;
    print(password);
    AuthCredential credentials = EmailAuthProvider.getCredential(
      email: firebaseUser.email,
      password: pw
    );
    print(firebaseUser.email);
    print(password);
    
    try{
      
      var authResult = await firebaseUser.reauthenticateWithCredential(credentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> validateEmailAndPassword(String email, String password) async{
    FirebaseUser firebaseUser = await _auth.currentUser();
    String em = email;
    String pw = password;
    AuthCredential credentials = EmailAuthProvider.getCredential(
      email: em,
      password: pw
    );
    print("fbuser");
    print(firebaseUser);
    print(em);
    print(pw);

    

    try{
      
      var authResult = await firebaseUser.reauthenticateWithCredential(credentials);
      print("authResult");
      //print(authResult);
      return true;
    } catch (e) {
      print(e);
      print("ERR");
      return false;
    }
  }

  Future<void> updateUserPassword(String password) async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    firebaseUser.updatePassword(password);

  }

  Future<bool> updateUserEmail(String email) async{

      if(email.contains('@') && email.contains('.')){
        FirebaseUser firebaseUser = await _auth.currentUser();
        print(firebaseUser.updateEmail(email));
        return true;
      }
      else
      {
        print("bad email");
        return false;
      }
      

    
  }
  //use this function to delete user in clickable event
  // onTap: () async {  
  //    await AuthService().deleteUser(email, password);
  // }



}
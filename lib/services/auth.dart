import 'package:firebase_auth/firebase_auth.dart';
import 'package:noname/models/user.dart';
import 'package:noname/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String err = "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null, null)";
  
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
      if (e.toString() == err ){
        return err;
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
}
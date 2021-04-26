import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noname/models/models.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  
  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String location) async {
    return await userCollection.document(uid).setData({
      'uid' : uid,
      'firstName': firstName,
      'lastName' : lastName,
      'location' : location,
    });
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return UserData(
        uid: doc.data['uid'] ?? '',
        firstName: doc.data['firstName'] ?? '',
        lastName: doc.data['lastName'] ?? '',
        location: doc.data['location'] ?? '',
        );
    }).toList();
  }

  //get userinfo stream
  Stream<List<UserData>> get users{
    return userCollection.snapshots()
      .map(_userListFromSnapshot);
      
  }

  //userData from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
      location: snapshot.data['location'],
    );
  }

  Stream<UserData> get usersData {
    return userCollection.document(uid).snapshots()
    .map(_userDataFromSnapShot);
  }

    Future deleteuser() {
    return userCollection.document(uid).delete();
  }

  // Stream<QuerySnapshot> get users{
  //   return userCollection.snapshots();    
  // }
  
  // Future getCurrentUserData() async{
  //   try {
  //     DocumentSnapshot ds = await userCollection.document(uid).get();
  //     String firstName = ds.get('firstName');
  //     String lastName = ds.get('firstName');
  //     String location = ds.get('firstName');
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
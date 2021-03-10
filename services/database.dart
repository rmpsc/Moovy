import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noname/models/userData.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  
  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String location) async {
    return await userCollection.document(uid).setData({
      'firstName': firstName,
      'lastName' : lastName,
      'location' : location,
    });
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return UserData(
        firstName: doc.data['firstName'] ?? '',
        lastName: doc.data['lastName'] ?? '',
        location: doc.data['location'] ?? '',
        );
    }).toList();
  }



  //get userinfo strea
  Stream<List<UserData>> get users{
    return userCollection.snapshots()
      .map(_userListFromSnapshot);
      
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
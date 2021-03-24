class UserData{
  String uid;
  String firstName;
  String lastName;
  String location;

  UserData({this.uid,this.firstName,this.lastName,this.location});

  UserData.fromMap(Map<String, dynamic> data){
    uid = data['uid'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    location = data['location'];
  }
}
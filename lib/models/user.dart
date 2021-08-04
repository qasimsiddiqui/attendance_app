import 'package:cloud_firestore/cloud_firestore.dart';

class UserUID {
  final String uid;
  final bool isSignedIn;

  UserUID({this.uid, this.isSignedIn});
}

class UserData {
  String uid;
  String name;
  String email;
  String number;
  bool isStudent;

  UserData({this.name, this.email, this.number, this.isStudent, this.uid});

  UserData.initialData(String userID)
      : uid = userID,
        name = "",
        email = "",
        number = "",
        isStudent = false;

  UserData.fromSnapshot(DocumentSnapshot snapshot, bool isStd, String userUID)
      : name = snapshot['name'],
        uid = userUID,
        email = snapshot['email'],
        number = snapshot['number'],
        isStudent = isStd;

  @override
  String toString() {
    return "UID: $uid, Name: $name, Email: $email, Number: $number, isStudent: $isStudent";
  }
}

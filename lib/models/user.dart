import 'package:cloud_firestore/cloud_firestore.dart';

class UserUID {
  final String uid;
  final bool isSignedIn;

  UserUID({this.uid, this.isSignedIn});
}

class User {
  String uid;
  String name;
  String email;
  String number;
  bool isStudent;

  User({this.name, this.email, this.number, this.isStudent, this.uid});

  User.initialData(String userID)
      : uid = userID,
        name = "",
        email = "",
        number = "",
        isStudent = false;

  User.fromSnapshot(DocumentSnapshot snapshot, bool isStd, String userUID)
      : name = snapshot['name'],
        uid = userUID,
        email = snapshot['email'],
        number = snapshot['number'],
        isStudent = isStd;
}

class UserUID {
  final String uid;

  UserUID({this.uid});
}

class User {
  String uid;
  String name;
  String email;
  String number;
  bool isStudent;

  User({this.name, this.email, this.number, this.isStudent, this.uid});
  set userName(String n) {
    name = n;
  }

  set userEmail(String n) {
    email = n;
  }

  set userNumber(String n) {
    number = n;
  }

  set userIsStudent(bool n) {
    isStudent = n;
  }
}

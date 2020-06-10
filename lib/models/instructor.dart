import 'package:cloud_firestore/cloud_firestore.dart';

class Instructor {
  String name;
  String email;
  String number;
  List<String> courses;

  Instructor({this.courses, this.name, this.email, this.number});

  Instructor.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        email = snapshot['email'],
        number = snapshot['number'],
        courses = List.from(['courses']);

  Instructor.initialData()
      : name = '',
        email = '',
        number = '',
        courses = [];
}

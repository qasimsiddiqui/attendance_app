import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendance_app/models/course.dart';

class Instructor {
  String name;
  String email;
  String number;
  List<CourseNameAndID> courses = new List<CourseNameAndID>();

  Instructor({this.courses, this.name, this.email, this.number});

  Instructor.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        email = snapshot['email'],
        number = snapshot['number'],
        courses = snapshot['courses'].map<CourseNameAndID>((course) {
          return CourseNameAndID.fromMap(course);
        }).toList();
}

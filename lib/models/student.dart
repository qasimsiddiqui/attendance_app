import 'package:attendance_app/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String name;
  final String email;
  final String number;
  final String regNo;
  List<CourseIDAndInstructorID> courses;

  Student({this.name, this.email, this.number, this.regNo});

  Student.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        email = snapshot['email'],
        number = snapshot['number'],
        regNo = snapshot['registration_No'],
        courses = snapshot['courses'].map<CourseIDAndInstructorID>((course) {
          return CourseIDAndInstructorID.fromMap(course);
        }).toList();

  @override
  String toString() {
    return "Name: $name, Email: $email, Number: $number,Reg#: $regNo, Courses: ${courses.toString()}";
  }
}

class StudentUID {
  final String uid;

  StudentUID(this.uid);
}

class RegisteredStudents {
  int noOfAttendedLectures;
  int noOfAbsents;

  RegisteredStudents({this.noOfAbsents, this.noOfAttendedLectures});
}

class PresentStudents {
  List<StudentUID> present;

  PresentStudents({this.present});
}

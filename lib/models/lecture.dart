import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture {
  int noOfPresentStudents;
  int creditHours;
  DateTime dateTime;
  double averageAttendance;
  String attendanceCode;

  Lecture(
      {this.noOfPresentStudents,
      this.creditHours,
      this.dateTime,
      this.averageAttendance,
      this.attendanceCode});

  Lecture.fromSnapshot(DocumentSnapshot snapshot)
      : noOfPresentStudents = snapshot['noOfPresentStudents'],
        creditHours = snapshot['creditHours'],
        dateTime = snapshot['dateTime'],
        averageAttendance = snapshot['averageAttendance'],
        attendanceCode = snapshot['attendanceCode'];

  Lecture.initialData()
      : noOfPresentStudents = 0,
        creditHours = 0,
        dateTime = DateTime.now(),
        averageAttendance = 0,
        attendanceCode = '';
}

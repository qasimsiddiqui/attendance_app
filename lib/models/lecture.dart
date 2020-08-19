import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture {
  int noOfPresentStudents;
  int creditHours;
  Timestamp dateTime;
  //DateTime dateTime;
  int averageAttendance;
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
        dateTime = Timestamp.now(),
        averageAttendance = 0,
        attendanceCode = '';

  @override
  String toString() {
    return 'noOfPresentStudents : $noOfPresentStudents\ncreditHours : $creditHours\ndateTime : ${dateTime.toString()}\naverageAttendance : $averageAttendance%\nattendanceCode : $attendanceCode';
  }
}

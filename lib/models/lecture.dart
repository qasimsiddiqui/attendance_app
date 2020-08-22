import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture {
  String lectureName;
  int noOfPresentStudents;
  int creditHours;
  Timestamp dateTime;
  //DateTime dateTime;
  String averageAttendance;
  String attendanceCode;

  Lecture(
      {this.lectureName,
      this.noOfPresentStudents,
      this.creditHours,
      this.dateTime,
      this.averageAttendance,
      this.attendanceCode});

  Lecture.fromSnapshot(DocumentSnapshot snapshot)
      : lectureName = snapshot['lectureName'],
        noOfPresentStudents = snapshot['noOfPresentStudents'],
        creditHours = snapshot['creditHours'],
        dateTime = snapshot['dateTime'],
        averageAttendance = snapshot['averageAttendance'],
        attendanceCode = snapshot['attendanceCode'];

  Lecture.initialData()
      : lectureName = '',
        noOfPresentStudents = 0,
        creditHours = 0,
        dateTime = Timestamp.now(),
        averageAttendance = '0',
        attendanceCode = '';

  @override
  String toString() {
    return 'lectureName: $lectureName\nnoOfPresentStudents : $noOfPresentStudents\ncreditHours : $creditHours\ndateTime : ${dateTime.toString()}\naverageAttendance : $averageAttendance%\nattendanceCode : $attendanceCode';
  }
}

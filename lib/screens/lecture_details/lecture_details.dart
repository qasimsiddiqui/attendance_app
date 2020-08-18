import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/models/user.dart';
import 'package:provider/provider.dart';

class LectureDetails extends StatelessWidget {
  LectureDetails({this.lecture});

  final Lecture lecture;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      drawer: appDrawer(user),
      appBar: AppBar(
        title: Text('Lecture Details'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Text("noOfPresentStudents : ${lecture.noOfPresentStudents}"),
            Text("creditHours : ${lecture.creditHours}"),
            Text("dateTime : ${lecture.dateTime}"),
            Text("averageAttendance : ${lecture.averageAttendance}"),
            Text("attendanceCode : ${lecture.attendanceCode}")
          ],
        ),
      ),
    );
  }
}

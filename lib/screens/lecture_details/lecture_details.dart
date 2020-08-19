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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                "noOfPresentStudents : ${lecture.noOfPresentStudents}\n\n" +
                    "creditHours : ${lecture.creditHours}\n\n" +
                    "dateTime : ${lecture.dateTime}\n\n" +
                    "averageAttendance : ${lecture.averageAttendance}%\n\n" +
                    "attendanceCode : ${lecture.attendanceCode}\n\n",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

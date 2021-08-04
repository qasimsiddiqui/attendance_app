import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/screens/show_present_students/show_present_students.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LectureDetails extends StatelessWidget {
  LectureDetails({this.lecture, this.course});

  final Lecture lecture;
  final Course course;

  @override
  Widget build(BuildContext context) {
    UserData user = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${lecture.lectureName} Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              detailBox("Number Of Present Students: ",
                  lecture.noOfPresentStudents.toString()),
              SizedBox(height: 5),
              detailBox("Credit Hours: ", lecture.creditHours.toString()),
              SizedBox(height: 5),
              detailBox(
                  "Date & Time :",
                  DateFormat.yMMMd()
                      .add_jm()
                      .format(lecture.dateTime.toDate())),
              SizedBox(height: 5),
              detailBox(
                  "Average Attendance :", lecture.averageAttendance + " %"),
              SizedBox(height: 5),
              user.isStudent
                  ? Container()
                  : detailBox("Attendance Code: ", lecture.attendanceCode),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text('Show Present Students',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ShowPresentStudents(
                                      course: course,
                                      lecture: lecture,
                                    )));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

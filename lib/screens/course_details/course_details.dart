import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  CourseDetails({this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Details')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 5),
              detailBox('Course Name :', course.name),
              detailBox('Course Code :', course.courseCode),
              detailBox('Session :', course.session),
              detailBox('Registration Code :', course.id),
              detailBox('Credit Hours :', course.totalCreditHours),
              detailBox('Credit Hours Done :', course.creditHoursDone),
              detailBox('Number of Lectures :', course.noOfLectures),
              detailBox("Number of Students :", course.noOfStudents),
            ]),
          ),
        ),
      ),
    );
  }
}

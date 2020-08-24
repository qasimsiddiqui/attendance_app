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
              SizedBox(height: 20),
              Text(
                'Course Name: ${course.name}',
                style: textStyling,
              ),
              SizedBox(height: 20),
              Text(
                'Course Code: ${course.courseCode}',
                style: textStyling,
              ),
              SizedBox(height: 20),
              Text(
                'Session: ${course.session}',
                style: textStyling,
              ),
              SizedBox(height: 20),
              Text(
                'Registration Code: ${course.id}',
                style: textStyling,
              ),
              SizedBox(height: 20),
              Text(
                'Credit Hours: ${course.totalCreditHours}',
                style: textStyling,
              ),
              SizedBox(height: 20),
              Text(
                'Credit Hours Done: ${course.creditHoursDone}',
                style: textStyling,
              ),
              SizedBox(height: 20),
              Text(
                'No of Lectures: ${course.noOfLectures}',
                style: textStyling,
              ),
              SizedBox(height: 20),
              Text(
                'No of Students: ${course.noOfStudents}',
                style: textStyling,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

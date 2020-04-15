import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/screens/course_details/course_details.dart';
import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  final CourseNameAndID course;

  CourseTile({this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.dvr),
            radius: 25.0,
          ),
          title: Text(course.name + '(' + course.id + ')'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CourseDetails()));
          },
        ),
      ),
    );
  }
}

import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/course_lecture_details/course_lecture_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseTile extends StatelessWidget {
  final Course course;

  CourseTile({this.course});

  @override
  Widget build(BuildContext context) {
    UserData user = Provider.of<UserData>(context);
    print(course.toString());

    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.dvr),
          radius: 25.0,
        ),
        title: Text(course.name),
        subtitle: Text("(" + course.id + ")"),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Provider.value(
                      value: user,
                      child: CourseLectureDetails(course: course))));
        },
      ),
    );
  }
}

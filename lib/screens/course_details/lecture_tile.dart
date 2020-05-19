import 'package:attendance_app/models/lecture.dart';
import 'package:flutter/material.dart';

class LectureTile extends StatelessWidget {
  final Lecture lecture;

  LectureTile({this.lecture});

  @override
  Widget build(BuildContext context) {
    print(lecture.creditHours);
    print(lecture.noOfPresentStudents);
    print(lecture.attendanceCode);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.dvr),
            radius: 25.0,
          ),
          title: Text("${lecture.creditHours} ( ${lecture.attendanceCode} )"),
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => Provider.value(
            //             value: user, child: CourseDetails(course: course))));
          },
        ),
      ),
    );
  }
}

import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/lecture_details/lecture_details.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class LectureTile extends StatelessWidget {
  final Lecture lecture;

  LectureTile({this.lecture});
  String _percentageAttendance() {
    if (double.parse(lecture.averageAttendance) == 100.00) {
      return lecture.averageAttendance.substring(0, 3);
    } else if (double.parse(lecture.averageAttendance) < 10.00) {
      return lecture.averageAttendance.substring(0, 1);
    } else {
      return lecture.averageAttendance.substring(0, 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    Course course = Provider.of<Course>(context);
    _percentageAttendance();
    print(double.parse(lecture.averageAttendance));
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.dvr),
              radius: 25.0,
            ),
            dense: false,
            trailing: new CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 5.0,
              percent: double.parse(lecture.averageAttendance) / 100,
              center: new Text(_percentageAttendance()),
              progressColor: Colors.green,
            ),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text("${lecture.lectureName}"),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                            providers: [Provider.value(value: user)],
                            child: LectureDetails(
                                lecture: lecture, course: course),
                          )));
            },
          ),
        ),
      ),
    );
  }
}

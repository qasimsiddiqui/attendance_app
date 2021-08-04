import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/student.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ShowRegisteredStudents extends StatelessWidget {
  ShowRegisteredStudents({this.course});

  final Course course;
  final List<double> attendancePercent = [];
  String _percentageAttendance(int index) {
    if (attendancePercent[index] == 1.00) {
      return (attendancePercent[index] * 100).toString().substring(0, 3);
    } else if (attendancePercent[index] < 0.10) {
      return (attendancePercent[index] * 100).toString().substring(0, 1);
    } else {
      return (attendancePercent[index] * 100).toString().substring(0, 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Student>>(
        stream: DatabaseService().getCourseRegisteredStudents(course),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          } else if (snapshot.data == null) {
            return Scaffold(
                appBar: AppBar(title: Text('Registered Students')),
                body: Loading());
          } else if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i].noOfAttendedLectures == 0) {
                attendancePercent.add(0);
              } else {
                attendancePercent.add(snapshot.data[i].noOfAttendedLectures /
                    int.parse(course.noOfLectures));
              }
            }
            return Scaffold(
              appBar: AppBar(title: Text('Registered Students')),
              body: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Card(
                        child: ListTile(
                          title: Text(
                              '${snapshot.data[index].name} (${snapshot.data[index].regNo})'),
                          subtitle: Text(
                              '${_percentageAttendance(index)}% Attendance'),
                          trailing: new CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            percent: attendancePercent[index],
                            center: new Text(_percentageAttendance(index)),
                            progressColor: attendancePercent[index] < 0.5
                                ? Colors.amber
                                : Colors.green,
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Text('Error');
          }
        });
  }
}

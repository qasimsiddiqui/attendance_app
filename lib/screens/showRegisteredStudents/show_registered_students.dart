import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/student.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';

class ShowRegisteredStudents extends StatelessWidget {
  const ShowRegisteredStudents({this.course});

  final Course course;

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
            List<double> attendancePercent = [0, 0, 0];
            for (int i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i].noOfAttendedLectures == 0) {
                attendancePercent[i] = 0;
              } else {
                attendancePercent[i] = snapshot.data[i].noOfAttendedLectures /
                    int.parse(course.noOfLectures);
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
                              '${attendancePercent[index] * 100} % Attendance'),
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}

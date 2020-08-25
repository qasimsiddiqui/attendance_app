import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/models/student.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowPresentStudents extends StatelessWidget {
  const ShowPresentStudents({this.course, this.lecture});

  final Course course;
  final Lecture lecture;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Student>>(
        stream: DatabaseService().getLecturePresentStudents(course, lecture),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          } else if (snapshot.data == null) {
            return Scaffold(
                appBar: AppBar(title: Text('Present Students')),
                body: Loading());
          } else if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text('Present Students')),
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
                              '${snapshot.data[index].attendanceTime.toDate()}'),
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}

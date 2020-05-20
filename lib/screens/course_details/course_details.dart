import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/screens/course_details/lecture_list.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/models/user.dart';
import 'package:provider/provider.dart';

class CourseDetails extends StatelessWidget {
  final Course course;

  CourseDetails({this.course});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamProvider<List<Lecture>>.value(
      value: DatabaseService(uid: user.uid, courseID: course.id).getLectures,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Course Details'),
        ),
        drawer: appDrawer(user),
        body: LectureList(),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add Lecture'),
          icon: Icon(Icons.add),
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => Provider<User>.value(
            //             value: user, child: AddCourse())));
          },
        ),
      ),
    );
  }
}

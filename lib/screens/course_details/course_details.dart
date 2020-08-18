import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/screens/add_lecture/add_lecture.dart';
import 'package:attendance_app/screens/course_details/lecture_list.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/models/user.dart';
import 'package:provider/provider.dart';

class CourseDetails extends StatelessWidget {
  CourseDetails({this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamProvider<List<Lecture>>.value(
      value: DatabaseService(uid: user.uid, courseID: course.id).getLectures,
      child: Scaffold(
        drawer: appDrawer(user),
        appBar: AppBar(
          title: Text('Lectures'),
          centerTitle: true,
        ),
        body: LectureList(),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add Lecture'),
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiProvider(providers: [
                          Provider<User>.value(
                            value: user,
                          ),
                          Provider<Course>.value(value: course)
                        ], child: AddLecture())));
          },
        ),
      ),
    );
  }
}

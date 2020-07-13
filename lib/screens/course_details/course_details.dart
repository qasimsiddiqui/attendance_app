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
  final Course course;

  CourseDetails({this.course});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamProvider<List<Lecture>>.value(
      value: DatabaseService(uid: user.uid, courseID: course.id).getLectures,
      child: Scaffold(
        drawer: appDrawer(user),
        body: NestedScrollView(
          headerSliverBuilder: (context, boo) => [
            SliverAppBar(
              pinned: true,
              title: Text('Course Details'),
              elevation: 0.0,
              expandedHeight: 150,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              //flexibleSpace: FlexibleSpaceBar(title: Text('')),
            ),
            Container(
                child: Column(
              children: <Widget>[
                Text('Course Name: ${course.name}'),
                Text('Course ID: ${course.id}'),
                Text('Course Code: ${course.courseCode}'),
                Text('Total Credit Hours: ${course.totalCreditHours}'),
                Text('Credit Hours Done: ${course.creditHoursDone}'),
                Text('Instructor UID: ${course.instructorUID}'),
                Text('No of Lectures: ${course.noOfLectures}'),
                Text('Session: ${course.session}'),
              ],
            ))
          ],
          body: LectureList(),
        ),
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

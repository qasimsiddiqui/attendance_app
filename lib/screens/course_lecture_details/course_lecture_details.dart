import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/screens/add_lecture/add_lecture.dart';
import 'package:attendance_app/screens/course_details/course_details.dart';
import 'package:attendance_app/screens/course_lecture_details/lecture_list.dart';
import 'package:attendance_app/screens/showRegisteredStudents/show_registered_students.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/models/user.dart';
import 'package:provider/provider.dart';

enum OptionSelected { showCourseDetails, showRegisteredStudents }

class CourseLectureDetails extends StatefulWidget {
  CourseLectureDetails({this.course});

  final Course course;

  @override
  _CourseLectureDetailsState createState() => _CourseLectureDetailsState();
}

class _CourseLectureDetailsState extends State<CourseLectureDetails> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    void _selectedOption(OptionSelected option) {
      if (option == OptionSelected.showCourseDetails) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseDetails(
                      course: widget.course,
                    )));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowRegisteredStudents(
                      course: widget.course,
                    )));
      }
    }

    return MultiProvider(
      providers: [
        StreamProvider<List<Lecture>>.value(
            value: DatabaseService(uid: user.uid, courseID: widget.course.id)
                .getLectures(user.isStudent, widget.course.instructorUID)),
        Provider<Course>.value(value: widget.course)
      ],
      child: Scaffold(
        drawer: appDrawer(user),
        appBar: AppBar(
          title: Text('Lectures'),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                onSelected: _selectedOption,
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<OptionSelected>>[
                      const PopupMenuItem<OptionSelected>(
                        value: OptionSelected.showCourseDetails,
                        child: Text('Show Course Details'),
                      ),
                      const PopupMenuItem<OptionSelected>(
                        value: OptionSelected.showRegisteredStudents,
                        child: Text('Show Registered Students'),
                      )
                    ])
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: LectureList(),
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
                          Provider<Course>.value(value: widget.course)
                        ], child: AddLecture())));
          },
        ),
      ),
    );
  }
}

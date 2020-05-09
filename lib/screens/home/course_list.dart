import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/instructor.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/screens/home/course_tile.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    final instructor = Provider.of<Instructor>(context);
    final List<CourseNameAndID> courses = instructor.courses ?? [];

    return instructor.courses == null
        ? Loading()
        : ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return CourseTile(course: courses[index]);
            },
          );
  }
}

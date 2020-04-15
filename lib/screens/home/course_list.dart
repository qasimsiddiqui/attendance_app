import 'package:attendance_app/models/instructor.dart';
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

    return ListView.builder(
      itemCount: instructor.courses.length ?? 1,
      itemBuilder: (context, index) {
        return CourseTile(course: instructor.courses[index]);
      },
    );
  }
}

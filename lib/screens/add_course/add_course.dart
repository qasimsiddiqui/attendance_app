import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/add_course/instructor_addCourse.dart';
import 'package:attendance_app/screens/add_course/student_addCourse.dart';
import 'package:flutter/material.dart';

class AddCourse extends StatelessWidget {
  final User user;

  const AddCourse({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user.isStudent ? StudentAddCourse() : InstructorAddCourse();
  }
}

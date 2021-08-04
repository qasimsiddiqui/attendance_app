import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/add_course/instructor_addCourse.dart';
import 'package:attendance_app/screens/add_course/student_addCourse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCourse extends StatelessWidget {
  const AddCourse({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return user.isStudent ? StudentAddCourse() : InstructorAddCourse();
  }
}

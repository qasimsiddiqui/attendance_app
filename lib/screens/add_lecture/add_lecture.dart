import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/add_lecture/instructor_addLecture.dart';
import 'package:attendance_app/screens/add_lecture/student_addLecture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLecture extends StatelessWidget {
  const AddLecture({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user.isStudent ? StudentAddLecture() : InstructorAddLecture();
  }
}

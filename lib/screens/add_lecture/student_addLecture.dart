import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentAddLecture extends StatefulWidget {
  @override
  _StudentAddLectureState createState() => _StudentAddLectureState();
}

class _StudentAddLectureState extends State<StudentAddLecture> {
  final _formKey = GlobalKey<FormState>();

  //Course _course;
  String attendanceCode = '';
  bool loading = false;
  final errorSnackBar = SnackBar(
    content: Text('Error Occured, Attendance not marked'),
  );
  final markedSnackBar = SnackBar(
    content: Text('Attendance Marked'),
  );

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final course = Provider.of<Course>(context);
    final DatabaseService _databaseService =
        DatabaseService(uid: user.uid, courseID: course.id);
    return loading
        ? Loading()
        : Scaffold(
            drawer: appDrawer(user),
            backgroundColor: Colors.blue[200],
            appBar: AppBar(
              title: Text('Add Lecture Attendance'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Container(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Enter attendance code:'),
                      onChanged: (val) {
                        setState(() => attendanceCode = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.red,
                      child: Text('Add Course'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);

                          dynamic result = await _databaseService
                              .addStudentLectureAttendance(
                                  course, attendanceCode);
                          if (result == null) {
                            setState(() => loading = false);
                            Navigator.pop(context);
                          } else {
                            print(result.toString());
                            setState(() => loading = false);
                            Navigator.pop(context);
                          }
                        }
                      },
                    )
                  ],
                ),
              )),
            ));
  }
}

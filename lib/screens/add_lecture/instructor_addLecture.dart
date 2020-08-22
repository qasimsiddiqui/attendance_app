import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class InstructorAddLecture extends StatefulWidget {
  @override
  _InstructorAddLectureState createState() => _InstructorAddLectureState();
}

class _InstructorAddLectureState extends State<InstructorAddLecture> {
  final _formKey = GlobalKey<FormState>();

  Lecture _lecture = new Lecture.initialData();
  String attendanceCode = randomAlphaNumeric(8).toUpperCase();
  int creditHours = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _course = Provider.of<Course>(context);
    final DatabaseService _databaseService =
        DatabaseService(uid: user.uid, courseID: _course.id);

    return loading
        ? Loading()
        : Scaffold(
            drawer: appDrawer(user),
            backgroundColor: Colors.blue[200],
            appBar: AppBar(
              title: Text('Add Lecture'),
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
                          labelText: 'Attendance Code'),
                      initialValue: attendanceCode,
                      readOnly: true,
                      onChanged: (val) {
                        setState(() => attendanceCode = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Enter credit Hours'),
                      onChanged: (val) {
                        setState(() => creditHours = int.parse(val));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('DateTimePickr will go here'),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.red,
                      child: Text('Add Lecture'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          _lecture.attendanceCode = attendanceCode;
                          _lecture.creditHours = creditHours;

                          dynamic result = await _databaseService
                              .addNewLectureInstructor(_course, _lecture);
                          if (result == null) {
                            _course.noOfLectures =
                                '${int.parse(_course.noOfLectures) + 1}';
                            _course.creditHoursDone =
                                '${int.parse(_course.creditHoursDone) + creditHours}';
                            setState(() => loading = false);
                            Navigator.pop(context);
                            Flushbar(
                              margin: EdgeInsets.all(10),
                              borderRadius: 8,
                              message: "Leture Added",
                              duration: Duration(seconds: 3),
                              backgroundGradient: LinearGradient(colors: [
                                Colors.green[300],
                                Colors.green[400]
                              ]),
                              backgroundColor: Colors.red,
                              boxShadows: [
                                BoxShadow(
                                  color: Colors.green[800],
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 3.0,
                                )
                              ],
                            )..show(context);
                          } else {
                            print(result.toString());
                            Flushbar(
                              margin: EdgeInsets.all(10),
                              borderRadius: 8,
                              message: result.toString(),
                              duration: Duration(seconds: 3),
                              backgroundGradient: LinearGradient(
                                  colors: [Colors.red[300], Colors.red[400]]),
                              backgroundColor: Colors.red,
                              boxShadows: [
                                BoxShadow(
                                  color: Colors.red[800],
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 3.0,
                                )
                              ],
                            )..show(context);
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

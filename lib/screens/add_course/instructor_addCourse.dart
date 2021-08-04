import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class InstructorAddCourse extends StatefulWidget {
  @override
  _InstructorAddCourseState createState() => _InstructorAddCourseState();
}

class _InstructorAddCourseState extends State<InstructorAddCourse> {
  final _formKey = GlobalKey<FormState>();

  //Course _course;
  String name = '';
  String courseCode = '';
  String session = '';
  String creditHours = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    final DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return loading
        ? Loading()
        : Scaffold(
            drawer: appDrawer(user),
            backgroundColor: Colors.blue[200],
            appBar: AppBar(
              title: Text('Add Course'),
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
                      scrollPadding: EdgeInsets.symmetric(vertical: 20.0),
                      textCapitalization: TextCapitalization.words,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Course Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter a Course Name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Enter a Course Code'),
                      onChanged: (val) {
                        setState(() => courseCode = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Session'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter a valid Session' : null,
                      onChanged: (val) {
                        setState(() => session = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Credit Hours:'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter credit hours of course' : null,
                      onChanged: (val) {
                        setState(() => creditHours = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Container(child: Text('Add Course')),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);

                          dynamic result =
                              await _databaseService.addInstructorCourse(
                                  name, courseCode, session, creditHours);
                          if (result == null) {
                            setState(() => loading = false);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: "Course Added",
                              backgroundColor: Colors.green,
                              toastLength: Toast.LENGTH_LONG,
                            );
                          } else {
                            print(result.toString());
                            Fluttertoast.showToast(
                              msg: result.toString(),
                              backgroundColor: Colors.red,
                              toastLength: Toast.LENGTH_LONG,
                            );
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

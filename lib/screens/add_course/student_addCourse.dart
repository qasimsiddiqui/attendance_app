import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentAddCourse extends StatefulWidget {
  @override
  _StudentAddCourseState createState() => _StudentAddCourseState();
}

class _StudentAddCourseState extends State<StudentAddCourse> {
  final _formKey = GlobalKey<FormState>();

  //Course _course;
  String courseID = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Enter a Course ID'),
                      onChanged: (val) {
                        setState(() => courseID = val);
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

                          dynamic result =
                              await _databaseService.addStudentCourse(courseID);
                          if (result == null) {
                            setState(() => loading = false);
                          } else {
                            print(result.toString());
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

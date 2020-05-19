import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstructorAddCourse extends StatefulWidget {
  @override
  _InstructorAddCourseState createState() => _InstructorAddCourseState();
}

class _InstructorAddCourseState extends State<InstructorAddCourse> {
  final _formKey = GlobalKey<FormState>();

  //Course _course;
  String name = '';
  String courseID = '';
  String session = '';

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
                          labelText: 'Enter a Course ID'),
                      onChanged: (val) {
                        setState(() => courseID = val);
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
                    RaisedButton(
                      color: Colors.red,
                      child: Text('Add Course'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);

                          dynamic result = await _databaseService
                              .addInstructorCourse(name, courseID, session);
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

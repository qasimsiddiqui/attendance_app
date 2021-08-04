import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
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
                    DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'd MMMM, yyyy - hh:mm a',
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      //icon: Icon(Icons.event),
                      dateLabelText: 'Date Time',
                      use24HourFormat: false,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Select Date and Time'),
                      onChanged: (date) =>
                          setState(() => _dateTime = DateTime.parse(date)),
                      validator: (date) {
                        setState(() => _dateTime = DateTime.parse(date) ?? '');
                        return null;
                      },
                      onSaved: (date) {
                        print('confirm $date');
                        setState(() {
                          _dateTime = DateTime.parse(date);
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text('Add Lecture'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          _lecture.attendanceCode = attendanceCode;
                          _lecture.creditHours = creditHours;
                          _lecture.dateTime = Timestamp.fromDate(_dateTime);

                          dynamic result = await _databaseService
                              .addNewLectureInstructor(_course, _lecture);
                          if (result == null) {
                            _course.noOfLectures =
                                '${int.parse(_course.noOfLectures) + 1}';
                            _course.creditHoursDone =
                                '${int.parse(_course.creditHoursDone) + creditHours}';
                            setState(() => loading = false);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: "Leture Added",
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

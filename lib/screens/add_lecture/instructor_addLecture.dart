import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
  String _dateString = "Select Date";
  String _timeString = "Select Time";

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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                        DatePicker.showDateTimePicker(
                          context,
                          theme: DatePickerTheme(
                            containerHeight: 220.0,
                          ),
                          showTitleActions: true,
                          minTime: DateTime(2015, 1, 1),
                          maxTime: DateTime(2025, 12, 31),
                          currentTime: DateTime.now(),
                          locale: LocaleType.en,
                          onConfirm: (date) {
                            print('confirm $date');
                            setState(() {
                              _dateTime = date;
                              _dateString =
                                  "Date: ${_dateTime.day} - ${_dateTime.month} - ${_dateTime.year}";
                              _timeString =
                                  "Time: ${_dateTime.hour > 12 ? _dateTime.hour - 12 : _dateTime.hour}:";
                              if (_dateTime.minute < 10) {
                                _timeString =
                                    _timeString + "0${_dateTime.minute}";
                              } else {
                                _timeString =
                                    _timeString + "${_dateTime.minute}";
                              }
                              if (_dateTime.hour > 12) {
                                _timeString = _timeString + " PM";
                              } else {
                                _timeString = _timeString + " AM";
                              }
                            });
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 70.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 20, 5),
                                        child: Icon(
                                          Icons.date_range,
                                          size: 18.0,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _dateString,
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                          Text(
                                            _timeString,
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "  Change",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
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

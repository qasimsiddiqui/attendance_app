import 'package:attendance_app/screens/authetication/instructor_register.dart';
import 'package:attendance_app/screens/authetication/student_register.dart';
import 'package:flutter/material.dart';

enum UserRole { instructor, student }

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[300],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
        elevation: 0.0,
        title: Text('Register to app'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                  child: Text('Student'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentRegisterPage()),
                    );
                  }),
              RaisedButton(
                  child: Text('Instructor'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InstructorRegisterPage()),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

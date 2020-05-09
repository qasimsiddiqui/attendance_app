import 'package:attendance_app/screens/authetication/instructor_register.dart';
import 'package:attendance_app/screens/authetication/student_register.dart';
import 'package:attendance_app/shared/constants.dart';
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
      body: Container(
        decoration: backgroundDecoration,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red)),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/user.png',
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          Text(
                            'Student',
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentRegisterPage()),
                      );
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/business_user.png',
                          ),
                          Text('Instructor')
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InstructorRegisterPage()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Already Registered?'),
                  FlatButton(
                      color: Colors.red,
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/models/user.dart';
import 'package:provider/provider.dart';

class CourseDetails extends StatelessWidget {
  final CourseNameAndID course;

  CourseDetails({this.course});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.name ?? ''),
            accountEmail: Text(user.email ?? ''),
          ),
          ListTile(title: Text(user.uid ?? '')),
          ListTile(title: Text(user.isStudent ? 'Student' : 'Instructor')),
          ListTile(title: Text(user.number ?? ''))
        ],
      )),
      body: Column(
        children: <Widget>[
          ListTile(title: Text('Name : ${course.name}')),
          ListTile(title: Text('ID : ${course.id}')),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add Lecture'),
        icon: Icon(Icons.add),
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Provider<User>.value(
          //             value: user, child: AddCourse())));
        },
      ),
    );
  }
}

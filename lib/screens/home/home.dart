import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/add_course/add_course.dart';
import 'package:attendance_app/services/auth.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/screens/home/course_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final userUID = Provider.of<UserUID>(context);
    final user = Provider.of<UserData>(context);

    // print(userUID.uid);

    return StreamProvider<List<Course>>.value(
        value: DatabaseService(uid: userUID.uid).getCourses(user.isStudent),
        initialData: [],
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await _authService.signOut();
                },
              )
            ],
          ),
          body: CourseList(),
          drawer: appDrawer(user),
          floatingActionButton: FloatingActionButton.extended(
            label: Text('Add Course'),
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Provider<UserData>.value(
                              value: user, child: AddCourse())))
                  .then((value) => setState(() {}));
            },
          ),
        ));
  }
}

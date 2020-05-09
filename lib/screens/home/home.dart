import 'package:attendance_app/models/instructor.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/add_course/add_course.dart';
import 'package:attendance_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/screens/home/course_list.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final userUID = Provider.of<UserUID>(context);
    final user = Provider.of<User>(context);

    print(userUID.uid);

    return StreamProvider<Instructor>.value(
        initialData: Instructor.initialData(),
        value: DatabaseService(uid: userUID.uid).instructorData,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, boo) => [
              SliverAppBar(
                pinned: true,
                title: Text('Home Page'),
                elevation: 0.0,
                actions: <Widget>[
                  FlatButton.icon(
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
                expandedHeight: 150,
                backgroundColor: Colors.red,
              )
            ],
            body: CourseList(),
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
          floatingActionButton: FloatingActionButton.extended(
            label: Text('Add Course'),
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Provider<User>.value(
                          value: user, child: AddCourse())));
            },
          ),
        ));
  }
}

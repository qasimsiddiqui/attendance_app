import 'package:attendance_app/screens/authetication/authenticate.dart';
import 'package:attendance_app/screens/home/home.dart';
import 'package:attendance_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);

    //returns either the authenticate or home Widget
    if (user == null) {
      return Authenticate();
    } else {
      return FutureProvider<User>.value(
        initialData: User(
            uid: user.uid, name: '', number: '', email: '', isStudent: false),
        value: DatabaseService(uid: user.uid).getUserData,
        child: Home(),
      );
    }
  }
}

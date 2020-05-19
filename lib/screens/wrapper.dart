import 'package:attendance_app/screens/authetication/authenticate.dart';
import 'package:attendance_app/screens/home/home.dart';
import 'package:attendance_app/services/database.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/models/user.dart';

// This wrapper makes use of auth stream to determine whether the
// Home screen should be displayed or the SignIn/Register screeen
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);

    //returns either the authenticate or home Widget
    if (user == null) {
      return Loading();
    } else if (user.isSignedIn == false) {
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

import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserUID>.value(
      value: AuthService().userChangeStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Wrapper(),
      ),
    );
  }
}

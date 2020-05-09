import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/services/auth.dart';
import 'package:attendance_app/shared/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    // StreamProvider is created here which manages the Auth of the user if the
    // auth status changes the value is sent down the widget tree from here
    return StreamProvider<UserUID>.value(
      value: AuthService().userChangeStream,
      child: MaterialApp(
        theme: ThemeData(
          textTheme: Typography(platform: TargetPlatform.android).black.apply(
                bodyColor: Colors.black,
                displayColor: Colors.white,
              ),
          scaffoldBackgroundColor: Colors.cyan[700],
        ),
        debugShowCheckedModeBanner: true,
        home: Wrapper(),
      ),
    );
  }
}

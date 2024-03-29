import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    // StreamProvider is created here which manages the Auth of the user if the
    // auth status changes the value is sent down the widget tree from here
    StreamProvider<UserUID>(
      create: (_) => AuthService().userChangeStream,
      initialData: null,
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.cyan[800],
      ),
      debugShowCheckedModeBanner: true,
      home: Wrapper(),
    );
  }
}

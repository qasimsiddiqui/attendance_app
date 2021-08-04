import 'package:attendance_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/registration_fields.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text Field State
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: backgroundDecoration,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 50),
                            Text.rich(TextSpan(
                                text: 'Attendance Management System',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.white))),
                            SizedBox(height: 30),
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Email',
                                    errorStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                validator: validateEmail,
                                onChanged: (val) {
                                  setState(() => email = val);
                                }),
                            SizedBox(height: 10.0),
                            TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Password',
                                    errorStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                validator: (val) => val.length < 6
                                    ? 'Enter a password 6+ characters long'
                                    : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() => password = val);
                                }),
                            SizedBox(height: 20),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Colors.cyan,
                                ),
                                child: Text('Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _authService
                                        .signInWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = 'Could Not Sign In';
                                        loading = false;
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Sign In Sucessful",
                                        backgroundColor: Colors.green,
                                        toastLength: Toast.LENGTH_LONG,
                                      );
                                    }
                                  }
                                }),
                            SizedBox(height: 10),
                            Text(error,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12)),
                            Divider(
                              color: Colors.white,
                              height: 20,
                            ),
                            Text('or Select an option to Register',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(height: 20),
                            SignInButton(Buttons.Email,
                                text: "Register with Email", onPressed: () {
                              widget.toggleView();
                            }),
                            SignInButton(Buttons.Google,
                                text: "Register with Google", onPressed: () {
                              //_authService.signInWithGoogle();
                            })
                          ]))),
            ),
          );
  }
}

import 'package:attendance_app/services/auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/registration_fields.dart';
import 'package:attendance_app/shared/loading.dart';

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
                                style: Theme.of(context).textTheme.headline4
                                //  TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 30,
                                //     color: Colors.white)
                                )),
                            SizedBox(height: 30),
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Email'),
                                validator: validateEmail,
                                onChanged: (val) {
                                  setState(() => email = val);
                                }),
                            SizedBox(height: 10.0),
                            TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Password'),
                                validator: (val) => val.length < 6
                                    ? 'Enter a password 6+ characters long'
                                    : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() => password = val);
                                }),
                            SizedBox(height: 20),
                            RaisedButton(
                                elevation: 8,
                                padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.cyan,
                                child: Text('Sign In',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
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
                                      Flushbar(
                                        margin: EdgeInsets.all(10),
                                        borderRadius: 8,
                                        message: "Sign In Sucessful",
                                        duration: Duration(seconds: 3),
                                        backgroundGradient: LinearGradient(
                                            colors: [
                                              Colors.green[300],
                                              Colors.green[400]
                                            ]),
                                        backgroundColor: Colors.red,
                                        boxShadows: [
                                          BoxShadow(
                                            color: Colors.green[800],
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 3.0,
                                          )
                                        ],
                                      )..show(context);
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: AssetImage(
                                        'assets/images/business_user.png',
                                      ),
                                    ),
                                    onTap: () {
                                      widget.toggleView();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      radius: 25,
                                      child: Text('Google'),
                                      backgroundColor: Colors.transparent,
                                      // backgroundImage: AssetImage(
                                      //     'assets/images/business_user.png'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      radius: 25,
                                      child: Text('FaceBook'),
                                      backgroundColor: Colors.transparent,
                                      // backgroundImage: AssetImage(
                                      //     'assets/images/business_user.png'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]))),
            ),
          );
  }
}

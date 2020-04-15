import 'package:attendance_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/shared/constants.dart';
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

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required.';
    }
    final RegExp nameExp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.lightBlue[300],
            appBar: AppBar(
              backgroundColor: Colors.lightBlue[700],
              elevation: 0.0,
              title: Text('Sign In'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person_add),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: _validateEmail,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
                      SizedBox(height: 10.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ characters long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      SizedBox(height: 10),
                      RaisedButton(
                          color: Colors.purple,
                          child: Text('Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _authService
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Could Not Sign In';
                                  loading = false;
                                });
                              }
                            }
                          }),
                      SizedBox(height: 10),
                      Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 12))
                    ]))),
          );
  }
}

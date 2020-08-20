import 'package:attendance_app/services/auth.dart';
import 'package:attendance_app/shared/constants.dart';
import 'package:attendance_app/shared/registration_fields.dart';
import 'package:flutter/material.dart';

class InstructorRegisterPage extends StatefulWidget {
  @override
  _InstructorRegisterPageState createState() => _InstructorRegisterPageState();
}

class _InstructorRegisterPageState extends State<InstructorRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  //text Field State
  String _name = '';
  String _number = '';
  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Instructor Register'), centerTitle: true),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Container(
              width: MediaQuery.of(context).size.width,
              //color: Colors.white54,
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Name', icon: Icon(Icons.person)),
                      validator: validateName,
                      onChanged: (val) {
                        setState(() => _name = val);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Mobile Number',
                            icon: Icon(Icons.phone)),
                        validator: validateNumber,
                        onChanged: (val) {
                          setState(() => _number = val);
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Email', icon: Icon(Icons.email)),
                        validator: validateEmail,
                        onChanged: (val) {
                          setState(() => _email = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Password',
                            icon: Icon(Icons.account_circle)),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ characters long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => _password = val);
                        }),
                    SizedBox(height: 10),
                    RaisedButton(
                        color: Colors.purple,
                        child: Text('Register',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _authService
                                .registerInstructorWithEmailAndPassword(
                                    _name, _number, _email, _password);
                            if (result == null) {
                              setState(() {
                                _error = 'please supply a valid email';
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        }),
                    SizedBox(height: 10),
                    Text(_error,
                        style: TextStyle(color: Colors.red, fontSize: 12))
                  ]))),
        ),
      ),
    );
  }
}

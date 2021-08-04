import 'package:attendance_app/shared/constants.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration,
      child: Center(child: CircularProgressIndicator()
          //SpinKitChasingDots(color: Colors.red, size: 50.0),
          ),
    );
  }
}

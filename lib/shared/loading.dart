import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: Center(child: CircularProgressIndicator()
          //SpinKitChasingDots(color: Colors.red, size: 50.0),
          ),
    );
  }
}

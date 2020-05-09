import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0)));

const backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    //Dark Ocean
    // Color.fromRGBO(55, 59, 68, 100),
    // Color.fromRGBO(66, 134, 244, 100)

    //Flare
    // Color.fromRGBO(241, 39, 17, 100),
    // Color.fromRGBO(245, 175, 25, 100)

    //Azur Lane
    // Color.fromRGBO(127, 127, 213, 100),
    // Color.fromRGBO(134, 168, 231, 100),
    // Color.fromRGBO(145, 234, 228, 100)
    //Harvey
    // Color.fromRGBO(31, 64, 55, 100),
    // Color.fromRGBO(153, 242, 200, 100)
    // Moonlit Astroid
    Color.fromRGBO(15, 32, 39, 100),
    Color.fromRGBO(32, 58, 67, 100),
    Color.fromRGBO(54, 93, 120, 100),
    // Colors.cyan,
    // Colors.cyan[900]
  ], // whitish to gray
  tileMode: TileMode.mirror,
));

import 'package:attendance_app/models/user.dart';
import 'package:flutter/material.dart';

const textStyling =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20);

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
    Color.fromRGBO(15, 32, 39, 100),
    Color.fromRGBO(32, 58, 67, 100),
    Color.fromRGBO(54, 93, 120, 100),
    // Colors.cyan,
    // Colors.cyan[900]
  ], // whitish to gray
  tileMode: TileMode.mirror,
));

Drawer appDrawer(UserData user) {
  return Drawer(
      child: Column(
    children: <Widget>[
      UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
            child: user.isStudent
                ? Image.asset(
                    'assets/images/user.png',
                    width: 60,
                  )
                : Image.asset(
                    'assets/images/business_user.png',
                    width: 60,
                  )),
        decoration: backgroundDecoration,
        accountName: Text(user.name ?? ''),
        accountEmail: Text(user.email ?? ''),
      ),
      ListTile(title: Text(user.isStudent ? 'Student' : 'Instructor')),
      ListTile(title: Text(user.number ?? ''))
    ],
  ));
}

String percentageAttendance(String avgAttendance) {
  if (double.parse(avgAttendance) == 100.00) {
    return avgAttendance.substring(0, 3);
  } else if (double.parse(avgAttendance) < 10.00) {
    return avgAttendance.substring(0, 1);
  } else {
    return avgAttendance.substring(0, 2);
  }
}

Widget detailBox(String title, String detail) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
    child: Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(
          detail,
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

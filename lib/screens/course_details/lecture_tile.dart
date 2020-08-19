import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/screens/lecture_details/lecture_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureTile extends StatelessWidget {
  final Lecture lecture;

  LectureTile({this.lecture});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.dvr),
              radius: 25.0,
            ),
            title: Text("${lecture.lectureName}"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                            providers: [Provider.value(value: user)],
                            child: LectureDetails(lecture: lecture),
                          )));
            },
          ),
        ),
      ),
    );
  }
}

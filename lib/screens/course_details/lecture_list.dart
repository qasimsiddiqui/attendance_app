import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/screens/course_details/lecture_tile.dart';
import 'package:attendance_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureList extends StatefulWidget {
  @override
  _LectureListState createState() => _LectureListState();
}

class _LectureListState extends State<LectureList> {
  @override
  Widget build(BuildContext context) {
    final lectures = Provider.of<List<Lecture>>(context);

    return lectures == null
        ? Loading()
        : ListView.builder(
            itemCount: lectures.length,
            itemBuilder: (context, index) {
              return LectureTile(lecture: lectures[index]);
            },
          );
  }
}

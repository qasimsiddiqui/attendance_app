import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String id;
  String instructorUID;
  String name;
  String courseCode;
  String session;
  String noOfLectures;
  String totalCreditHours;
  String creditHoursDone;
  String noOfStudents;

  Course(
      {this.id,
      this.instructorUID,
      this.name,
      this.courseCode,
      this.session,
      this.noOfLectures,
      this.totalCreditHours,
      this.creditHoursDone,
      this.noOfStudents});

  Course.initialData()
      : id = '',
        instructorUID = '',
        name = '',
        courseCode = '',
        session = '',
        noOfLectures = '0',
        totalCreditHours = '0',
        creditHoursDone = '0',
        noOfStudents = '0';

  Course.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot['id'],
        instructorUID = snapshot['instructor_uid'],
        name = snapshot['name'],
        courseCode = snapshot['course_code'],
        session = snapshot['session'],
        noOfLectures = snapshot['no_of_lectures'],
        totalCreditHours = snapshot['total_credit_hours'],
        creditHoursDone = snapshot['credit_hours_done'],
        noOfStudents = snapshot['no_of_students'];

  @override
  String toString() {
    return "Course ID: $id , Instructor ID: $instructorUID , Course Name: $name ($courseCode)";
  }
}

class CourseIDAndInstructorID {
  String instructorUID;
  String courseID;

  CourseIDAndInstructorID({this.instructorUID, this.courseID});

  CourseIDAndInstructorID.fromMap(Map<dynamic, dynamic> map)
      : instructorUID = map['instructor_uid'],
        courseID = map['course_id'];
}

class CourseNameAndID {
  String name;
  String id;

  CourseNameAndID(this.name, this.id);

  CourseNameAndID.fromMap(Map<dynamic, dynamic> map)
      : name = map['name'],
        id = map['id'];

  String get courseName {
    return name;
  }

  String get courseID {
    return id;
  }

  set courseName(String _cName) {
    name = _cName;
  }

  set courseID(String _cID) {
    name = _cID;
  }
}

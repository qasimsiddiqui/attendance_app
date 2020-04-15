class Course {
  String id;
  String instructorUID;
  String name;
  String code;
  String session;
  int noOfLectures;
  int totalCreditHours;
  int creditHoursDone;

  Course(
      {this.id,
      this.instructorUID,
      this.name,
      this.code,
      this.session,
      this.noOfLectures,
      this.totalCreditHours,
      this.creditHoursDone});
}

class CourseNameAndID {
  String name;
  String id;

  CourseNameAndID(this.name, this.id);

  CourseNameAndID.fromMap(Map<dynamic, dynamic> map)
      : name = map['name'],
        id = map['id'];

  set courseName(String _cName) {
    name = _cName;
  }

  set courseID(String _cID) {
    name = _cID;
  }
}

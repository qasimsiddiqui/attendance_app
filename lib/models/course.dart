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

  Course.initialData()
      : id = '',
        instructorUID = '',
        name = '',
        code = '',
        session = '',
        noOfLectures = 0,
        totalCreditHours = 0,
        creditHoursDone = 0;
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

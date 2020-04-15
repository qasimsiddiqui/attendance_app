class StudentUID {
  final String uid;

  StudentUID(this.uid);
}

class Student {
  final String name;
  final String email;
  final String number;
  final String regNo;

  Student({this.name, this.email, this.number, this.regNo});
}

class RegisteredStudents {
  int noOfAttendedLectures;
  int noOfAbsents;

  RegisteredStudents({this.noOfAbsents, this.noOfAttendedLectures});
}

class PresentStudents {
  List<StudentUID> present;

  PresentStudents({this.present});
}

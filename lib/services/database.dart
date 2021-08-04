import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/student.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/models/instructor.dart';
import 'package:attendance_app/models/user.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService({this.courseID, this.uid});

  final String courseID;
  final String uid;

  //collection reference
  final CollectionReference _instructorCollection =
      FirebaseFirestore.instance.collection('instructors');

  final CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection('students');

  // bool determineUser(UserUID userUID) {
  //   Future<bool> instruct = _instructorCollection.doc(uid).get().then((doc){
  //     if(doc.exists){
  //       return true;
  //     }
  //     else{
  //       return false;
  //     }
  //   });
  //   if(instruct != null){

  //   }
  // }

  // Future<bool> determineUser(User user) async {
  //   bool isStudent = false;
  //   try {
  //     await _instructorCollection.doc(uid).get().then((doc) {
  //       if (doc.exists)
  //         isStudent = false;
  //       else
  //         isStudent = true;
  //     });
  //     return isStudent;
  //   } catch (e) {
  //     return null;
  //   }

  //   user = await _instructorCollection.doc(uid).get().then((doc) {
  //     User r;
  //     if (doc.exists) {
  //       r = new User(
  //           name: doc.data['name'],
  //           uid: uid,
  //           email: doc.data['email'],
  //           number: doc.data['number'],
  //           isStudent: false);
  //     } else {
  //       _studentCollection.doc(uid).get().then((doc) {
  //         if (doc.exists) {
  //           user = new User(
  //               name: doc.data['name'],
  //               uid: uid,
  //               email: doc.data['email'],
  //               number: doc.data['number'],
  //               isStudent: true);
  //         } else {
  //           user = null;
  //         }
  //       });
  //     }
  //   });
  // }

  //     .snapshots()
  //     .map((DocumentSnapshot snapshot) {
  //   return User.fromSnapshot(snapshot, false);
  // });
  Future<UserData> get getUserData async {
    UserData user;
    try {
      DocumentSnapshot instructorSnapshot =
          await _instructorCollection.doc(uid).get();

      if (instructorSnapshot.exists) {
        user = new UserData.fromSnapshot(instructorSnapshot, false, uid);
      } else {
        DocumentSnapshot studentSnapshot =
            await _studentCollection.doc(uid).get();

        if (studentSnapshot.exists) {
          user = new UserData.fromSnapshot(studentSnapshot, true, uid);
        } else {
          user = new UserData.initialData(uid);
        }
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///            `STUDENT METHODS`
  ///
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  // TODO complete Student mathods

  Future addStudentCourse(String courseID) async {
    // String code = await addStudentCourseData(name, id, session);

    //query the course ID in instructors collection to check if course exists
    QuerySnapshot courseExist = await _instructorCollection
        .where("courses", arrayContains: courseID)
        .get();

    //ID of Instructor whose course it is
    List<String> instructorUID = courseExist.docs.map((e) => e.id).toList();

    //checks to see if only one course is found
    if (instructorUID.isEmpty) {
      return "Course does not Exist";
    } else if (instructorUID.length != 1) {
      return "More than one courses found";
    } else {
      await _instructorCollection
          .doc(instructorUID[0])
          .collection('courses')
          .doc(courseID)
          .collection('registered_students')
          .doc(uid)
          .set({'no_of_attended_lec': 0});

      DocumentSnapshot _courseDocument = await _instructorCollection
          .doc(instructorUID[0])
          .collection('courses')
          .doc(courseID)
          .get();

      await _instructorCollection
          .doc(instructorUID[0])
          .collection('courses')
          .doc(courseID)
          .update({
        'no_of_students': "${int.parse(_courseDocument['no_of_students']) + 1}"
      });

      await _studentCollection.doc(uid).update({
        'courses': FieldValue.arrayUnion([
          {'instructor_uid': instructorUID[0], 'course_id': courseID}
        ])
      });
    }
  }

  Future updateStudentData(
      String name, String regNo, String number, String email) async {
    return await _studentCollection.doc(uid).set({
      'registration_No': regNo,
      'name': name,
      'number': number,
      'email': email,
      'courses': []
    });
  }

  //student list from snapshot
  List<Student> _studentListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Student(
          email: doc['email'] ?? '',
          name: doc['name'] ?? '',
          regNo: doc['registration No'] ?? '',
          number: doc['number'] ?? '');
    }).toList();
  }

  //get students stream
  Stream<List<Student>> get students {
    return _studentCollection.snapshots().map(_studentListFromSnapshot);
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///            `INSTRUCTOR METHODS`
  ///
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  Stream<Instructor> get instructorData {
    return _instructorCollection
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      return Instructor.fromSnapshot(snapshot);
    });
  }

  Future updateInstructorData(String name, String number, String email) async {
    return await _instructorCollection
        .doc(uid)
        .set({'name': name, 'number': number, 'email': email, 'courses': []});
  }

  Future addInstructorCourse(String name, String courseCode, String session,
      String creditHours) async {
    String id =
        await addInstructorCourseData(name, courseCode, session, creditHours);

    return await _instructorCollection
        .doc(uid)
        .update({
          'courses': FieldValue.arrayUnion([id])
        })
        .then((doc) {
          print("DOC saved");
        })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print("Error on doc save");
          print(error);
        });
  }

  //Instructor list from snapshot
  List<Instructor> _instructorListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      return Instructor.fromSnapshot(snapshot);
      // return Instructor(
      //     email: doc.data['email'] ?? '',
      //     name: doc.data['name'] ?? '',
      //     number: doc.data['number'] ?? '');
    }).toList();
  }

  //get instructors stream
  Stream<List<Instructor>> get instructors {
    return _instructorCollection.snapshots().map(_instructorListFromSnapshot);
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///           `STUDENT METHODS`
  ///
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  Future addInstructorCourseData(String name, String courseCode, String session,
      String creditHours) async {
    String id = _instructorCollection.doc(uid).collection('courses').doc().id;

    await _instructorCollection.doc(uid).collection('courses').doc(id).set({
      'name': name,
      'course_code': courseCode,
      'session': session,
      'credit_hours_done': "0",
      'instructor_uid': uid,
      'no_of_lectures': "0",
      'no_of_students': "0",
      'total_credit_hours': creditHours,
      'id': id ?? ''
    });

    return id;
  }

  //Course list from snapshot
  List<Course> _courseListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Course.fromSnapshot(doc);
    }).toList();
  }

  Stream<List<Course>> _getStudentCourses() async* {
    List<Course> courseList = [];

    DocumentSnapshot stdDoc = await _studentCollection.doc(uid).get();
    Student _student = new Student.fromSnapshot(stdDoc, 0);

    if (_student.courses.length == 0) {
      return; //TODO add appropriate return type
    } else {
      int len = _student.courses.length - 1;
      while (len >= 0) {
        DocumentSnapshot snapshot = await _instructorCollection
            .doc(_student.courses[len].instructorUID)
            .collection('courses')
            .doc(_student.courses[len].courseID)
            .get();
        //print(snapshot.data);
        Course course = new Course.fromSnapshot(snapshot);
        courseList.add(course);

        print(courseList.length);
        len--;
      }
      yield courseList;
    }
  }

  Stream<List<Course>> _getInstructorCourses() {
    return _instructorCollection
        .doc(uid)
        .collection('courses')
        .snapshots()
        .map(_courseListFromSnapshot);
  }

  //get courses stream
  Stream<List<Course>> getCourses(bool isStudent) {
    if (isStudent) {
      return _getStudentCourses();
    } else {
      return _getInstructorCourses();
    }
  }

  //Course list from snapshot
  List<Lecture> _lectureListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((DocumentSnapshot snapshot) {
      return Lecture.fromSnapshot(snapshot);
    }).toList();
  }

  Stream<List<Lecture>> _getStudentLectures(String instructorUID) {
    return _instructorCollection
        .doc(instructorUID)
        .collection('courses')
        .doc(courseID)
        .collection('lectures')
        .snapshots()
        .map(_lectureListFromSnapshot);
  }

  Stream<List<Lecture>> _getInstructorLectures() {
    return _instructorCollection
        .doc(uid)
        .collection('courses')
        .doc(courseID)
        .collection('lectures')
        .snapshots()
        .map(_lectureListFromSnapshot);
  }

  //get courses stream
  Stream<List<Lecture>> getLectures(bool isStudent, String instructorUID) {
    if (isStudent) {
      return _getStudentLectures(instructorUID);
    } else {
      return _getInstructorLectures();
    }
  }

  Future addNewLectureInstructor(Course course, Lecture lecture) async {
    String nextLectureNumber = "${int.parse(course.noOfLectures) + 1}";
    String creditHoursDone =
        "${int.parse(course.creditHoursDone) + lecture.creditHours}";
    lecture.lectureName = "Lecture $nextLectureNumber";
    await _instructorCollection
        .doc(uid)
        .collection('courses')
        .doc(courseID)
        .collection('lectures')
        .doc(lecture.lectureName)
        .set({
      'lectureName': lecture.lectureName,
      'noOfPresentStudents': lecture.noOfPresentStudents,
      'creditHours': lecture.creditHours,
      'dateTime': lecture.dateTime,
      'averageAttendance': lecture.averageAttendance,
      'attendanceCode': lecture.attendanceCode
    });
    await _instructorCollection
        .doc(uid)
        .collection('courses')
        .doc(courseID)
        .update({
      'no_of_lectures': nextLectureNumber,
      'credit_hours_done': creditHoursDone
    });
  }

  Future addStudentLectureAttendance(
      Course course, String attendanceCode) async {
    print(attendanceCode);
    QuerySnapshot queryResult = await _instructorCollection
        .doc(course.instructorUID)
        .collection('courses')
        .doc(courseID)
        .collection('lectures')
        .where('attendanceCode', isEqualTo: attendanceCode)
        .get();

    //get a list of all lectures that have this attendanceCode.
    //only one should be return, this is done just in case
    List<Lecture> lecturesList =
        queryResult.docs.map((e) => Lecture.fromSnapshot(e)).toList();
    for (var lecture in lecturesList) {
      print(lecture.toString());
    }
    //checks to see if only one course is found
    if (lecturesList.isEmpty) {
      return "Either Attendance Code is invalid or Lecture does not Exist";
    } else if (lecturesList.length != 1) {
      return "More than one lectures found";
    } else {
      DocumentSnapshot studentAlreadyExists = await _instructorCollection
          .doc(course.instructorUID)
          .collection('courses')
          .doc(courseID)
          .collection('lectures')
          .doc(lecturesList[0].lectureName)
          .collection('present_students')
          .doc(uid)
          .get();

      if (!studentAlreadyExists.exists) {
        await _instructorCollection
            .doc(course.instructorUID)
            .collection('courses')
            .doc(courseID)
            .collection('lectures')
            .doc(lecturesList[0].lectureName)
            .collection('present_students')
            .doc(uid)
            .set({'attendanceTime': Timestamp.now()});

        await _instructorCollection
            .doc(course.instructorUID)
            .collection('courses')
            .doc(courseID)
            .collection('registered_students')
            .doc(uid)
            .update({'no_of_attended_lec': FieldValue.increment(1)});
      } else {
        return "Attendance Already Marked";
      }
    }

    int noOfPresentStudents = lecturesList[0].noOfPresentStudents + 1;
    int noOfStudents = int.parse(course.noOfStudents);
    double avgAttendance =
        (noOfPresentStudents.toDouble() / noOfStudents.toDouble()) * 100;
    String avgAttendanceString = '${avgAttendance.toStringAsFixed(2)}';
    await _instructorCollection
        .doc(course.instructorUID)
        .collection('courses')
        .doc(courseID)
        .collection('lectures')
        .doc(lecturesList[0].lectureName)
        .set({
      'noOfPresentStudents': noOfPresentStudents,
      'averageAttendance': avgAttendanceString,
    }, SetOptions(merge: true));
  }

  Stream<List<Student>> getCourseRegisteredStudents(Course course) async* {
    List<Student> studentList = [];

    QuerySnapshot regStudentsQuery = await _instructorCollection
        .doc(course.instructorUID)
        .collection('courses')
        .doc(course.id)
        .collection('registered_students')
        .get();

    if (regStudentsQuery.docs.length == 0) {
      return; //TODO add appropriate return type
    } else {
      for (DocumentSnapshot doc in regStudentsQuery.docs) {
        DocumentSnapshot studentDoc =
            await _studentCollection.doc(doc.id).get();

        Student _student =
            new Student.fromSnapshot(studentDoc, doc['no_of_attended_lec']);
        studentList.add(_student);
        print(_student.toString());
      }
      yield studentList;
    }
  }

  Stream<List<Student>> getLecturePresentStudents(
      Course course, Lecture lecture) async* {
    List<Student> studentList = [];

    QuerySnapshot presentStudentsQuery = await _instructorCollection
        .doc(course.instructorUID)
        .collection('courses')
        .doc(course.id)
        .collection('lectures')
        .doc(lecture.lectureName)
        .collection('present_students')
        .get();

    if (presentStudentsQuery.docs.length == 0) {
      return; //TODO add appropriate return type
    } else {
      for (DocumentSnapshot doc in presentStudentsQuery.docs) {
        DocumentSnapshot studentDoc =
            await _studentCollection.doc(doc.id).get();

        Student _student = new Student.fromSnapshotWithTimeStamp(
            studentDoc, doc['attendanceTime']);
        studentList.add(_student);
        print(_student.toString());
      }
      yield studentList;
    }
  }
}

// Course IDs:
//GlSp6kW9Qn1pz82Ct9gR
//RF3DfFlAbIhAP69P4g97

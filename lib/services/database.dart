import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/student.dart';
import 'package:attendance_app/models/lecture.dart';
import 'package:attendance_app/models/instructor.dart';
import 'package:attendance_app/models/user.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  DatabaseService({this.courseID, this.uid});

  final String uid;
  final String courseID;

  //collection reference
  final CollectionReference _instructorCollection =
      Firestore.instance.collection('instructors');

  final CollectionReference _studentCollection =
      Firestore.instance.collection('students');

  // bool determineUser(UserUID userUID) {
  //   Future<bool> instruct = _instructorCollection.document(uid).get().then((doc){
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
  //     await _instructorCollection.document(uid).get().then((doc) {
  //       if (doc.exists)
  //         isStudent = false;
  //       else
  //         isStudent = true;
  //     });
  //     return isStudent;
  //   } catch (e) {
  //     return null;
  //   }

  //   user = await _instructorCollection.document(uid).get().then((doc) {
  //     User r;
  //     if (doc.exists) {
  //       r = new User(
  //           name: doc.data['name'],
  //           uid: uid,
  //           email: doc.data['email'],
  //           number: doc.data['number'],
  //           isStudent: false);
  //     } else {
  //       _studentCollection.document(uid).get().then((doc) {
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
  Future<User> get getUserData async {
    User user;
    try {
      DocumentSnapshot instructorSnapshot =
          await _instructorCollection.document(uid).get();

      if (instructorSnapshot.exists) {
        user = new User.fromSnapshot(instructorSnapshot, false, uid);
      } else {
        DocumentSnapshot studentSnapshot =
            await _studentCollection.document(uid).get();

        if (studentSnapshot.exists) {
          user = new User.fromSnapshot(studentSnapshot, true, uid);
        } else {
          user = new User.initialData(uid);
        }
      }
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///            `STUDENT METHODS`
  ///
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  /// TODO complete Student mathods

  Future addStudentCourse(String courseID) async {
    // String code = await addStudentCourseData(name, id, session);

    //query the course ID in instructors collection to check if course exists
    QuerySnapshot courseExist = await _instructorCollection
        .where("courses", arrayContains: courseID)
        .getDocuments();

    //ID of Instructor whose course it is
    List<String> instructorUID =
        courseExist.documents.map((e) => e.documentID).toList();

    //checks to see if only one course is found
    if (instructorUID.isEmpty) {
      return "Course does not Exist";
    } else if (instructorUID.length != 1) {
      return "More than one courses found";
    } else {
      await _instructorCollection
          .document(instructorUID[0])
          .collection('courses')
          .document(courseID)
          .collection('registered_students')
          .document(uid)
          .setData({'no_of_attended_lec': 0, 'absents': 0});

      await _studentCollection.document(uid).updateData({
        'courses': FieldValue.arrayUnion([
          {'instructor_uid': instructorUID[0], 'course_id': courseID}
        ])
      });
    }
  }

  Future updateStudentData(
      String name, String regNo, String number, String email) async {
    return await _studentCollection.document(uid).setData({
      'registration_No': regNo,
      'name': name,
      'number': number,
      'email': email,
      'courses': []
    });
  }

  //student list from snapshot
  List<Student> _studentListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((doc) {
      return Student(
          email: doc.data['email'] ?? '',
          name: doc.data['name'] ?? '',
          regNo: doc.data['registration No'] ?? '',
          number: doc.data['number'] ?? '');
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
        .document(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      return Instructor.fromSnapshot(snapshot);
    });
  }

  Future updateInstructorData(String name, String number, String email) async {
    return await _instructorCollection.document(uid).setData(
        {'name': name, 'number': number, 'email': email, 'courses': []});
  }

  Future addInstructorCourse(
      String name, String courseCode, String session) async {
    String id = await addInstructorCourseData(name, courseCode, session);

    return await _instructorCollection
        .document(uid)
        .updateData({
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
    return querySnapshot.documents.map((snapshot) {
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

  Future addInstructorCourseData(
      String name, String courseCode, String session) async {
    String id = _instructorCollection
        .document(uid)
        .collection('courses')
        .document()
        .documentID;

    await _instructorCollection
        .document(uid)
        .collection('courses')
        .document(id)
        .setData({
      'name': name,
      'course_code': courseCode,
      'session': session,
      'id': id ?? ''
    });

    return id;
  }

  //Course list from snapshot
  List<Course> _courseListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((doc) {
      return Course.fromSnapshot(doc);
    }).toList();
  }

  Stream<List<Course>> _getStudentCourses() async* {
    List<Course> courseList = new List();

    DocumentSnapshot stdDoc = await _studentCollection.document(uid).get();
    Student _student = new Student.fromSnapshot(stdDoc);

    if (_student.courses.length == 0) {
      return; //TODO add appropriate return type
    } else {
      int len = _student.courses.length - 1;
      while (len >= 0) {
        DocumentSnapshot snapshot = await _instructorCollection
            .document(_student.courses[len].instructorUID)
            .collection('courses')
            .document(_student.courses[len].courseID)
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
        .document(uid)
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
    return querySnapshot.documents.map((DocumentSnapshot snapshot) {
      return Lecture.fromSnapshot(snapshot);
    }).toList();
  }

  Stream<List<Lecture>> _getStudentLectures(String instructorUID) {
    return _instructorCollection
        .document(instructorUID)
        .collection('courses')
        .document(courseID)
        .collection('lectures')
        .snapshots()
        .map(_lectureListFromSnapshot);
  }

  Stream<List<Lecture>> _getInstructorLectures() {
    return _instructorCollection
        .document(uid)
        .collection('courses')
        .document(courseID)
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

  Future createNewLectureDoc() async {
    String id = _instructorCollection
        .document(uid)
        .collection('courses')
        .document(courseID)
        .collection('lectures')
        .document()
        .documentID;

    await _instructorCollection
        .document(uid)
        .collection('courses')
        .document(courseID)
        .collection('lectures')
        .document(id)
        .setData({
      'no_of_present_students': 0,
      'credit_hour': 0, //TODO make this change
      'date': DateTime.now().toString(),
      'avg_attendance': 0,
      'attendance_code': ''
    });

    return id;
  }

  //TODO add the lecture numbers in the documents dynamically
  Future addNewLectureInstructor(Course course) async {
    String lectureDocID = await createNewLectureDoc();
  }
}

// Course IDs:
//GlSp6kW9Qn1pz82Ct9gR
//RF3DfFlAbIhAP69P4g97

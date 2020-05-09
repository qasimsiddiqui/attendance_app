import 'package:attendance_app/models/course.dart';
import 'package:attendance_app/models/student.dart';
import 'package:attendance_app/models/instructor.dart';
import 'package:attendance_app/models/user.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

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
  Future<User> get getUserData {
    User user;
    return _instructorCollection
        .document(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        user = new User.fromSnapshot(snapshot, false, uid);
      } else {
        _studentCollection
            .document(uid)
            .get()
            .then((DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            user = new User.fromSnapshot(snapshot, true, uid);
          } else {
            user = null;
          }
        });
      }
      return user;
    }).catchError((e) {
      print(e.toString());
    });
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///            `STUDENT METHODS`
  ///
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  //TODO

  Future addStudentCourse(String id) async {
    // String code = await addStudentCourseData(name, id, session);

    // return await _instructorCollection
    //     .document(uid)
    //     .updateData({
    //       'courses': FieldValue.arrayUnion([
    //         {'name': name, 'id': id, 'code': code, 'session': session}
    //       ])
    //     })
    //     .then((doc) {
    //       print("DOC saved");
    //     })
    //     .timeout(Duration(seconds: 10))
    //     .catchError((error) {
    //       print("Error on doc save");
    //       print(error);
    //     });
  }

  Future updateStudentData(
      String name, String regNo, String number, String email) async {
    return await _studentCollection.document(uid).setData({
      'registration No': regNo,
      'name': name,
      'number': number,
      'email': email,
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

  Future addInstructorCourse(String name, String id, String session) async {
    String code = await addInstructorCourseData(name, id, session);

    return await _instructorCollection
        .document(uid)
        .updateData({
          'courses': FieldValue.arrayUnion([
            {'name': name, 'id': id, 'code': code, 'session': session}
          ])
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

  Future addInstructorCourseData(String name, String id, String session) async {
    String code = _instructorCollection
        .document(uid)
        .collection('courses')
        .document()
        .documentID;

    await _instructorCollection
        .document(uid)
        .collection('courses')
        .document(code)
        .setData(
            {'name': name, 'code': code, 'session': session, 'id': id ?? ''});

    return code;
  }

  //Course list from snapshot
  List<Course> _courseListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((doc) {
      return Course(
          id: doc.data['id'] ?? '',
          name: doc.data['name'] ?? '',
          session: doc.data['session'] ?? '',
          code: doc.data['code'] ?? '');
    }).toList();
  }

  //get courses stream
  Stream<List<Course>> get courses {
    return _instructorCollection
        .document(uid)
        .collection('courses')
        .snapshots()
        .map(_courseListFromSnapshot);
  }
}

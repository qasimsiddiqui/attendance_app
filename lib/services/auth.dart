import 'package:attendance_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on a firebase user
  UserUID _userFromFirebaseUser(FirebaseUser user) {
    if (user != null)
      return UserUID(uid: user.uid, isSignedIn: true);
    else
      return UserUID(uid: '', isSignedIn: false);
    // if (user != null) {
    //   //return User(uid: user.uid);
    //   User userInfo;
    //   yield* await DatabaseService(uid: user.uid).determineUser().then((User result) {
    //     userInfo = result;
    //     return userInfo;
    //   }).catchError((e) {
    //     print('Error = ' + e.toString());
    //     return null;
    //   });
    // } else {
    //   return null;
    // }
  }

  //auth change user stream
  Stream<UserUID> get userChangeStream {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    //.map( (FirebaseUser user) => _userFromFirebaseUser(user) );
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerStudentWithEmailAndPassword(String name, String regNo,
      String number, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with uid
      await DatabaseService(uid: user.uid)
          .updateStudentData(name, regNo, number, email);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerInstructorWithEmailAndPassword(
      String name, String number, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with uid
      await DatabaseService(uid: user.uid)
          .updateInstructorData(name, number, email);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

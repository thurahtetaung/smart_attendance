import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smart_attendance/models/user.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final StorageReference ref =
      FirebaseStorage.instance.ref().child('user_photos');

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email & password
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

  // register with email & password
  Future registerWithEmailAndPassword(
      {String email,
      String password,
      String major,
      String name,
      int year,
      int roll,
      File img}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      ref.child(user.uid).putFile(img);
      // if (!uploadTask.isSuccessful) {
      //   throw Exception('Error on Uploading');
      // }
      await DatabaseService(uid: user.uid)
          .updateUserData(name: name, major: major, roll: roll, year: year);
      await DatabaseService(uid: user.uid).setDailyAttendance();
      await DatabaseService(uid: user.uid, major: major, year: year)
          .setAttendanceForUser();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

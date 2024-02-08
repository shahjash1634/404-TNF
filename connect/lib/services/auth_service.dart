import 'package:connect/helper/helper_functions.dart';
import 'package:connect/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseService databaseService = DatabaseService();

  Widget getProfileImage() {
    if (firebaseAuth.currentUser?.photoURL != null) {
      return Image.network(
        firebaseAuth.currentUser!.photoURL!,
        height: 100,
        width: 100,
      );
    } else {
      return Icon(Icons.account_circle, size: 100);
    }
  }

  //login
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        List<String> subjects = await databaseService.fetchingSubjects(email);

        await DatabaseService(uid: user.uid)
            .updateUserData(email, password, subjects);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future logInTeacherWithEmailAndPassword(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        await DatabaseService(uid: user.uid).updateTeacherData(email, password);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //logout
  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSF("");
      await HelperFunction.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future techerSignOut() async {
    try {
      await HelperFunction.saveTeacherLoggedInStatus(false);
      await HelperFunction.saveTeacherEmailSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}

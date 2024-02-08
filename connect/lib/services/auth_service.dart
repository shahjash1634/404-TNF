import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //logout
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //refence for our collection
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection("students");

  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection("teachers");

  //updating the userdata
  Future updateUserData(String email, String password) async {
    var newEmail = email.split("@");
    var new2 = newEmail[1].substring(0, 2);
    var new3 = newEmail[0].split("b");
    var year = 24 - (int.parse(new3.last));
    DateTime datetime = DateTime.now();
    var x = datetime.month.toInt();
    var y;
    if (year == 1) {
      if (x == 1 || x == 2 || x == 3 || x == 4 || x == 5 || x == 6) {
        y = "1";
      } else {
        y = "2";
      }
    } else if (year == 2) {
      if (x == 1 || x == 2 || x == 3 || x == 4 || x == 5 || x == 6) {
        y = "3";
      } else {
        y = "4";
      }
    } else if (year == 3) {
      if (x == 1 || x == 2 || x == 3 || x == 4 || x == 5 || x == 6) {
        y = "5";
      } else {
        y = "6";
      }
    } else if (year == 4) {
      if (x == 1 || x == 2 || x == 3 || x == 4 || x == 5 || x == 6) {
        y = "7";
      } else {
        y = "8";
      }
    } else {
      y = null;
    }
    return await studentCollection.doc(uid).set({
      //"name": "-",
      "email": email,
      "sem": y,
      "year": year,
      "branch": new2,
      "subjects": [],
      "uid": uid,
      "role": "student",
    });
  }
  Future updateTeacherData(String email, String password) async {
    var newEmail = email.split("@");
    var new2 = newEmail[1].substring(0, 2);
    return await teacherCollection.doc(uid).set({
      //"name": "-",
      "email": email,
      "branch": new2,
      "classes": [],
      "uid": uid,
      "role": "teacher",
    });
  }

  

  //getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await studentCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
  Future gettingTeacherData(String email) async {
    QuerySnapshot snapshot =
        await teacherCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //refence for our collection
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection("students");

  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection("teachers");

  final CollectionReference branchCollection =
      FirebaseFirestore.instance.collection("Branch");

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

  Stream<QuerySnapshot> gettingSubject(String email) async* {
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

    final branchsnapshot = await branchCollection
        .where(FieldPath.documentId, isEqualTo: new2.toUpperCase())
        .get();
    if (branchsnapshot.docs.isNotEmpty) {
      String branchId = branchsnapshot.docs[0].id;
      final CollectionReference semCollection = FirebaseFirestore.instance
          .collection("Branch")
          .doc(branchId)
          .collection("Sem");

      final semSnapshot =
          await semCollection.where(FieldPath.documentId, isEqualTo: y).get();

      if (semSnapshot.docs.isNotEmpty) {
        String semId = semSnapshot.docs[0].id;

        final CollectionReference subjectCollection = FirebaseFirestore.instance
            .collection("Branch")
            .doc(branchId)
            .collection("Sem")
            .doc(semId)
            .collection("Subjects");

        yield* subjectCollection.snapshots();
      }
    }
  }

 // gettingProfName(String email) {
 //  Stream<List<String>> profName =gettingSubject(email).map((QuerySnapshot snapshot) {
 //   return snapshot.docs.map((DocumentSnapshot document){
 //     return document['professor'] as String;
 //   }).toList();
 //  });
//
 // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  String gettingBranch(String email) {
    var newEmail = email.split("@");
    var new2 = newEmail[1].substring(0, 2);
    return new2;
  }

  num gettingYear(String email) {
    var newEmail = email.split("@");
    var new3 = newEmail[0].split("b");
    var year = 24 - (int.parse(new3.last));
    return year;
  }

  String gettingSem(String email) {
    var year = gettingYear(email);
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
    return y;
  }

  //updating the userdata
  Future updateUserData(
      String email, String password, List<String> subjects) async {
    var branch = gettingBranch(email);
    var sem = gettingSem(email);
    var year = gettingYear(email);
    return await studentCollection.doc(uid).set({
      //"name": "-",
      "email": email,
      "sem": sem,
      "year": year,
      "branch": branch,
      "subjects": subjects,
      "uid": uid,
      "role": "student",
    });
  }

  Future updateTeacherData(String email, String password) async {
    var branch = gettingBranch(email);
    return await teacherCollection.doc(uid).set({
      //"name": "-",
      "email": email,
      "branch": branch,
      "classes": [],
      "uid": uid,
      "role": "teacher",
    });
  }

  Future<void> storingStudentData() async {
    QuerySnapshot snapshot = await studentCollection.get();
    for (QueryDocumentSnapshot docs in snapshot.docs) {
      String branch = docs['branch'] as String;
      String sem = docs['sem'] as String;

       await branchCollection
          .doc(branch.toUpperCase())
          .collection('Sem')
          .doc(sem.toString())
          .collection('students')
          .doc(docs.id)
          .set(docs.data() as Map<String,dynamic>);
    }
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
    var branch = gettingBranch(email);
    var sem = gettingSem(email);
    final branchsnapshot = await branchCollection
        .where(FieldPath.documentId, isEqualTo: branch.toUpperCase())
        .get();
    if (branchsnapshot.docs.isNotEmpty) {
      String branchId = branchsnapshot.docs[0].id;
      final CollectionReference semCollection = FirebaseFirestore.instance
          .collection("Branch")
          .doc(branchId)
          .collection("Sem");

      final semSnapshot =
          await semCollection.where(FieldPath.documentId, isEqualTo: sem).get();

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

  Future<List<String>> fetchingSubjects(String email) async {
    var branch = gettingBranch(email);
    var sem = gettingSem(email);
    final CollectionReference subjectCollection = FirebaseFirestore.instance
        .collection("Branch")
        .doc(branch.toUpperCase())
        .collection("Sem")
        .doc(sem.toString())
        .collection("Subjects");
    QuerySnapshot querySnapshot = await subjectCollection.get();
    List<String> subjectIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return subjectIds;
  }

  Future<List> getStudentEmails() async {
    QuerySnapshot querySnapshot =
        await studentCollection.where('email', isEqualTo: true).get();
    List<String> studentEmails = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      studentEmails.add(doc['email']);
    }
    return studentEmails;
  }

  Future<List<String>> getStudentNamesForClass(
      List<String> studentEmails) async {
    String email;
    List<String> studentNames = [];
    for (String e in studentEmails) {
      email = e;

      var branch = gettingBranch(email);
      var sem = gettingSem(email);
      QuerySnapshot querySnapshot = await studentCollection
          .where('branch', isEqualTo: branch)
          .where("sem", isEqualTo: sem)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        studentNames.add(doc['name']);
      }
    }
    return studentNames;
  }

  Future<List<String>> getTeacherClasses() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot snapshot = await teacherCollection.doc(uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    List<String> classes = List<String>.from(data['classes'] ?? []);
    return classes;
  }

  Future<String> getTeacherBranch() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot snapshot = await teacherCollection.doc(uid).get();
    var data = snapshot.data() as Map<String, dynamic>;
    var branch = data['branch'] as String;
    return branch;
  }
}

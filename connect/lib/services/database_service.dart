import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //refence for our collection
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection("students");

  //getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await studentCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}

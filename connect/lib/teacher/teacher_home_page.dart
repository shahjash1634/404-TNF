import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/pages/login_page.dart';
import 'package:connect/services/auth_service.dart';
import 'package:connect/services/database_service.dart';
import 'package:connect/teacher/teacher_functions.dart';
import 'package:connect/widgets/drawer.dart';
import 'package:connect/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  AuthService authService = AuthService();
  DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 63, 21, 126),
          title: const Text(
            'Connect',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.calendar_month_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        drawer: const MyDrawer(),
        body: FutureBuilder(
            future: _databaseService.getTeacherClasses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              } else {
                List<String> classes = snapshot.data ?? [];
                return ListView.builder(
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      return _buildList(classes[index]);
                    });
              }
            }),
      ),
    );
  }

  FutureBuilder<String> _buildList(String className) {
    return FutureBuilder(
        future: _databaseService.getTeacherBranch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("Error : "),
            );
          } else {
            String branch = snapshot.data ?? "";
            return Card(
              //color: Color.fromARGB(255, 21, 2, 50).withOpacity(0.5),
              margin: EdgeInsets.all(16),
              child: ListTile(
                title: Text(className),
                subtitle: Text(branch.toUpperCase()),
                onTap: () {},
              ),
            );
          }
        });
  }
}

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
  final DatabaseService _databaseService = DatabaseService();
  late Future<List<String>> _teacherClassesFuture;

  @override
  void initState() {
    super.initState();
    _teacherClassesFuture = _databaseService.getTeacherClasses();
    _fetchCurrentSemester();
  }

  Future<String?> _fetchCurrentSemester() async {
    try {
      List<String> teacherClasses = await _teacherClassesFuture;
      if (teacherClasses.isNotEmpty) {
        String branch = await _databaseService.getTeacherBranch();
        String className = teacherClasses.first;
        String? semester =
            await _databaseService.getSemesterForSubject(branch, className);
        return semester;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching current semester: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF132248),
        appBar: AppBar(
          backgroundColor: Color(0xFF132248),
          title: const Text(
            'Connect',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.calendar_month_rounded)),
            IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.settings))
          ],
          iconTheme: IconThemeData(color: Colors.white),
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
            return FutureBuilder(
                future: _fetchCurrentSemester(),
                builder: (context, semesterSnapshot) {
                  if (semesterSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (semesterSnapshot.hasError) {
                    return Center(
                      child: Text("Error : ${semesterSnapshot.error}"),
                    );
                  } else {
                    String branch = snapshot.data ?? "";
                    String semester = semesterSnapshot.data ?? "";
                    return Card(
                        margin: EdgeInsets.all(16),
                        color:
                            Color.fromARGB(255, 56, 73, 148).withOpacity(0.5),
                        child: ListTile(
                          title: Text(
                            className,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 19),
                          ),
                          subtitle: Text(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              branch.toUpperCase() + " " + 'Sem: $semester'),
                          onTap: () {
                            nextScreenReplace(
                                context,
                                FunctionsPage(
                                  branch: branch,
                                  subject: className,
                                  semester: semester,
                                ));
                          },
                        ));
                  }
                });
          }
        });
  }
}

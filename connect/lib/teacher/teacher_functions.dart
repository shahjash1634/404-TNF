import 'package:connect/services/database_service.dart';
import 'package:connect/teacher/teacher_home_page.dart';
import 'package:connect/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DatabaseService databaseService = DatabaseService();
  late var emails;

  void initState() {
    super.initState();
    emails = databaseService.getStudentEmails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(156, 32, 3, 71),
        title: Text("Attendance Page "),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            nextScreenReplace(context, TeacherHomePage());
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
    );
  }
}

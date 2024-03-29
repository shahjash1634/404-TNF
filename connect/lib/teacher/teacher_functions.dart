// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:connect/services/database_service.dart';
import 'package:connect/teacher/attendance.dart';
import 'package:connect/teacher/teacher_home_page.dart';
import 'package:connect/widgets/widgets.dart';

class FunctionsPage extends StatefulWidget {
  final String branch;
  final String subject;
  final String semester;
  const FunctionsPage({
    Key? key,
    required this.branch,
    required this.subject,
    required this.semester,
  }) : super(key: key);

  @override
  State<FunctionsPage> createState() => _FunctionsPageState();
}

class _FunctionsPageState extends State<FunctionsPage> {
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
        backgroundColor: Color(0xFF132248),
        title: const Text("Teacher Functions"),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            nextScreenReplace(context, const TeacherHomePage());
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color(0xFF132248),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                nextScreenReplace(
                    context,
                    AttendancePage(
                      branch: widget.branch,
                      semester: widget.semester,
                      subject: widget.subject,
                    ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 56, 73, 148).withOpacity(0.5),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 19),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
              ),
              child: Text("Take Attendance"))),
    );
  }
}

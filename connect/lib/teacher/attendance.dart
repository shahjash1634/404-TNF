// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connect/services/database_service.dart';
import 'package:flutter/material.dart';

import 'package:connect/teacher/teacher_functions.dart';
import 'package:connect/widgets/widgets.dart';

class AttendancePage extends StatefulWidget {
  final String branch;
  final String semester;
  final String subject;
  const AttendancePage({
    Key? key,
    required this.branch,
    required this.semester,
    required this.subject,
  }) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<String> students = [];
  late Map<String, bool> attendance;
  late DatabaseService databaseService;

  @override
  void initState() {
    super.initState();
    databaseService = DatabaseService();
    fetchStudents();
  }

  void fetchStudents() async {
    List<String> fetchedStudents = await databaseService
        .fetchStudentsForBranchAndSem(widget.branch, widget.semester);

    setState(() {
      students = fetchedStudents;
      attendance = {for (var student in students) student: false};
    });
  }

  Future<void> saveAttendance() async {
    String date = DateTime.now().toString();
    try {
        // Save attendance for each student
    await Future.forEach(attendance.entries, (entry) async {
      String studentId = entry.key;
      bool isPresent = entry.value;
      
      await databaseService.saveAttendanceForStudent(
        widget.branch,
        widget.semester,
        widget.subject,
        studentId,
        date,
        isPresent,
      );
    });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance saved successfully!'),
        ),
      );
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error saving attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving attendance. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(156, 32, 3, 71),
        title: const Text("Attendance Page"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            nextScreenReplace(
                context,
                FunctionsPage(
                  branch: widget.branch,
                  subject: widget.subject,
                  semester: widget.semester,
                ));
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: students == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    title: Text(students[index]),
                    value: attendance[students[index]],
                    onChanged: (bool? value) {
                      setState(() {
                        attendance[students[index]] = value ?? false;
                      });
                    });
              },
            ),
      floatingActionButton: ElevatedButton(
          onPressed: saveAttendance, child: Text("Save Attendance")),
    );
  }
}

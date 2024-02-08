import 'package:connect/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SubjectPage extends StatefulWidget {
  final String subjectName;
  final String branch;
  final String semester;

  const SubjectPage({super.key, required this.subjectName, required this.branch, required this.semester});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<String> announcements = []; // List to store announcements
  double attendancePercentage = 0.0;
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Page'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 23),
        backgroundColor: const Color.fromARGB(230, 11, 15, 92),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF132248), Color.fromARGB(230, 11, 15, 92)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10),
                  child: const Text(
                    "ATTENDANCE :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                 FutureBuilder<double>(
                  future: _databaseService.fetchAttendancePercentage(widget.branch,widget.semester,widget.subjectName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      double attendancePercentage = snapshot.data ?? 0.0;
                      return Container(
                        padding: EdgeInsets.only(left: 130, bottom: 20),
                        child: Text(
                          attendancePercentage.toStringAsFixed(2) + '%',
                          style: const TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 10,
              percent: 0.0,
              progressColor: Colors.deepPurple,
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

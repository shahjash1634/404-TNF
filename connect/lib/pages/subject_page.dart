import 'package:connect/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectPage extends StatefulWidget {
  final String subjectName;
  final String branch;
  final String semester;
  final String email;

  const SubjectPage(
      {super.key,
      required this.subjectName,
      required this.branch,
      required this.semester,
      required this.email});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<String> announcements = []; // List to store announcements
  double attendancePercentage = 0.0;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _updateAttendancePercentage();
  }

  Future<void> _updateAttendancePercentage() async {
    try {
      double percentage =
          await _databaseService.calculateAttendancePercentageForStudent(
              widget.email, widget.branch, widget.semester, widget.subjectName);
      setState(() {
        attendancePercentage = percentage;
        print(attendancePercentage);
      });
    } catch (error) {
      print('Error updating attendance percentage: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 27, fontWeight: FontWeight.w700),
        backgroundColor: Color(0xFF132248),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        //decoration: const BoxDecoration(
        //gradient: LinearGradient(
        //colors: [Color(0xFF132248), Color.fromARGB(230, 11, 15, 92)],
        //),
        color: Color(0xFF132248),

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
                  child: Text(
                    "ATTENDANCE :",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 130, bottom: 20),
                  child: Text(
                    '${attendancePercentage.toStringAsFixed(2)}%',
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ],
            ),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 10,
              percent: attendancePercentage / 100,
              progressColor: Color.fromARGB(255, 63, 52, 146),
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

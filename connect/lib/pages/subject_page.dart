import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<String> announcements = []; // List to store announcements

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
                Container(
                  padding: EdgeInsets.only(left: 130, bottom: 20),
                  child: Text(
                    "Attendence percentage",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                )
              ],
            ),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 10,
              percent: 0.4,
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

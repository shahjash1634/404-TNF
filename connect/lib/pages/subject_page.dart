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
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF132248), Color.fromARGB(230, 11, 15, 92)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "ATTENDANCE :",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
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
              Column(
                children: [
                  const Text(
                    "ANNOUNCEMENTS :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Check if there are announcements
                  announcements.isEmpty
                      ? const Text(
                          "No Announcements",
                          style: TextStyle(color: Colors.white),
                        )
                      : Container(
                          height: announcements.length * 40.0,
                          child: ListView.builder(
                            itemCount: announcements.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  announcements[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/pages/calendar_page.dart';
import 'package:connect/pages/subject_page.dart';
import 'package:connect/services/auth_service.dart';
import 'package:connect/widgets/drawer.dart';
import 'package:connect/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:connect/services/database_service.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseService databaseService;
  AuthService authService = AuthService();
  Color myColor = const Color(0xFF132248);
  late Stream<QuerySnapshot> _stream;
  late String branch;
  late String sem;

  @override
  void initState() {
    super.initState();
    databaseService = DatabaseService();
    _stream = databaseService.gettingSubject(widget.email);
    branch = databaseService.gettingBranch(widget.email);
    sem = databaseService.gettingSem(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: myColor,
          title: Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/logo3.png"),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () {
                  nextScreenReplace(context, CalendarPage());
                },
                icon: const Icon(Icons.calendar_month_rounded)),
            IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.settings))
          ],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        backgroundColor: myColor,
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Connection error");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var docs = snapshot.data!.docs;
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 9,
                            mainAxisSpacing: 9),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      String documentId = docs[index].id;
                      String profName = docs[index]["professor"] as String;
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        color: const Color.fromARGB(255, 56, 73, 148)
                            .withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: GridTile(
                            // ignore: sort_child_properties_last
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                documentId,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            header: Container(
                              padding: const EdgeInsets.fromLTRB(8, 35, 16, 16),
                              child: Text(
                                profName,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            footer: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 2, 16, 53),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  print(branch + sem + documentId);
                                  nextScreen(
                                      context,
                                      SubjectPage(
                                        branch: branch,
                                        subjectName: documentId,
                                        semester: sem,
                                        email: widget.email,
                                      ));
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "More Info",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            )),
                      );
                    });
              }),
        ));
  }
}

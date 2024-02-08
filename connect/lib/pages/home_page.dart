import 'package:cloud_firestore/cloud_firestore.dart';
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
  Color myColor = const Color(0xFF2f3b61);
  late Stream<QuerySnapshot> _stream;

  void initState() {
    super.initState();
    databaseService = DatabaseService();
    _stream = databaseService.gettingSubject(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: const Color.fromARGB(230, 11, 15, 92),
        drawer: const MyDrawer(),
        body: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Connection error");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var docs = snapshot.data!.docs;
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 9),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    String documentId = docs[index].id;
                    String profName = docs[index]["professor"] as String;
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      color: const Color(0xFF7c7adf).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: GridTile(
                          // ignore: sort_child_properties_last
                          child: Text(
                            documentId,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          header: Container(
                            padding: const EdgeInsets.fromLTRB(0, 26, 16, 16),
                            child: Text(
                              profName,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          footer: Container(
                            decoration:
                                const BoxDecoration(color: Colors.deepOrange),
                            child: TextButton(
                              onPressed: () {
                                nextScreen(context, SubjectPage());
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
            }));
  }
}

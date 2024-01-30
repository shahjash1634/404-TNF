import 'package:connect/pages/login_page.dart';
import 'package:connect/pages/profile_page.dart';
import 'package:connect/services/auth_service.dart';
import 'package:connect/widgets/subject_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  Color myColor = const Color(0xFF2f3b61);

  Future<void> _launchURL(String url) async {
    /*final Uri url = Uri.parse('172.18.116.11');
    if (!await launchUrl(url)) {
      throw Exception(
          'Could not launch ,please ensure college wifi connection');
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 63, 21, 126),
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
        backgroundColor: Color.fromARGB(230, 11, 15, 92),
        drawer: Drawer(
            child: SingleChildScrollView(
          child: Container(
            color: myColor,
            child: Column(
              children: [
                DrawerHeader(
                  child: SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: Image.asset(
                      "assets/images/logo2.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Profile',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Handle profile option
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Announcements',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                Container(
                  color: myColor,
                  child: ListTile(
                    title: const Text('Subject 1',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: myColor,
                  child: ListTile(
                    title: const Text('Subject 2',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: myColor,
                  child: ListTile(
                    title: const Text('Subject 3',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: myColor,
                  child: ListTile(
                    title: const Text('Subject 4',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: myColor,
                  child: ListTile(
                    title: const Text('Subject 5',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: myColor,
                  child: ListTile(
                    title: const Text('Subject 6',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: myColor,
                  child: ListTile(
                    title: const Text('Subject 7',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: myColor,
                  child: ListTile(
                    title: const Text('Subject 8',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Course Reg.',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _launchURL('https://epayments.vjti.ac.in/');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Faculty feedback',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _launchURL('https://epayments.vjti.ac.in/');
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Settings',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            content:
                                const Text("Are you sure you want to logout?"),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await authService.signOut();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                      (route) => false);
                                },
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        )),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const SubjectWidget();
          },
        ));
  }
}

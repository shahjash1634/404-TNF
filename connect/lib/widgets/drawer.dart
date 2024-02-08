import 'package:connect/pages/login_page.dart';
import 'package:connect/pages/profile_page.dart';
import 'package:connect/services/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<void> _launchURL(String url) async {}

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF2f3b61),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: SizedBox(
                  height: 300.0, // Adjust the height as needed
                  width: 500.0, // Adjust the width as needed
                  child: Image.asset(
                    "assets/images/logo2.png",
                    height: 300.0, // Should match the SizedBox height
                    width: 500.0, // Should match the SizedBox width
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
                title: const Text(
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
                        content: const Text("Are you sure you want to logout?"),
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
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

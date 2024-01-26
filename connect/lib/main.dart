import 'package:connect/helper/helper_functions.dart';
import 'package:connect/pages/home_page.dart';
import 'package:connect/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Connect());
}

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  bool _isSignedIn = false;
  getUserLogedInStatus() async {
    await HelperFunction.getUserLogedInStatus().then((value) {
      if (value != null) {
        _isSignedIn = value;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLogedInStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const HomePage() : const LoginPage(),
    );
  }
}

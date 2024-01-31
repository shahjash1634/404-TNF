import 'package:connect/pages/login_page.dart';
import 'package:connect/services/auth_service.dart';
import 'package:connect/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: Center(
              child: ElevatedButton(
                  onPressed: () {
                    authService.techerSignOut();
                    nextScreenReplace(context, LoginPage());
                  },
                  child: Text("Logout")))),
    );
  }
}

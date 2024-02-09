import 'package:connect/helper/constants.dart';
import 'package:connect/helper/helper_functions.dart';
import 'package:connect/pages/home_page.dart';
import 'package:connect/pages/login_page.dart';
import 'package:connect/teacher/teacher_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const Connect());
}

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  bool _isSignedIn = false;
  bool _isTeacherSignedIn = false;
  getUserLogedInStatus() async {
    await HelperFunction.getUserLogedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  getTeacherLogedInStatus() async {
    await HelperFunction.getTeacherLogedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isTeacherSignedIn = value;
        });
      }
    });
  }

  Future<String?> getUserEmail() async {
    return await HelperFunction.getUserEmailSF();
  }

  @override
  void initState() {
    super.initState();
    getUserLogedInStatus();
    getTeacherLogedInStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSignedIn
          ? FutureBuilder<String?>(
              future: getUserEmail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // You can return a loading indicator if needed
                  return Center(child: const CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle the error
                  return Text("Error: ${snapshot.error}");
                } else {
                  // Pass the email to the HomePage widget
                  return HomePage(email: snapshot.data!);
                }
              },
            )
          : _isTeacherSignedIn
              ? const TeacherHomePage()
              : const LoginPage(),
    );
  }
}

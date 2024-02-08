import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/helper/helper_functions.dart';
import 'package:connect/pages/home_page.dart';
import 'package:connect/services/auth_service.dart';
import 'package:connect/services/database_service.dart';
import 'package:connect/teacher/teacher_home_page.dart';
import 'package:connect/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  DatabaseService databaseService = DatabaseService();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Form(
                key: formKey,
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color(0xFF132248),
                      Color.fromARGB(230, 11, 15, 92)
                    ],
                  )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150.0,
                        ),
                        Image.asset(
                          "assets/images/logo2.png",
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          height: 100.0,
                        ),
                        const Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: String.fromEnvironment(""),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(134, 255, 255, 255)),
                                    hintText: "Username",
                                    labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(134, 255, 255, 255)),
                                    labelText: "Username",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Color.fromARGB(134, 255, 255, 255),
                                    )),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                validator: (val) {
                                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val!) &&
                                          email.endsWith("vjti.ac.in")
                                      ? null
                                      : "Please enter a valid email";
                                },
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                obscureText: true,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    hintText: "Password",
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(134, 255, 255, 255)),
                                    labelText: "Password",
                                    labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(134, 255, 255, 255)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Color.fromARGB(134, 255, 255, 255),
                                    )),
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                validator: (val) {
                                  if (val!.length < 6) {
                                    return "Password must be atleast 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),

                              InkWell(
                                onTap: () async {
                                  login();
                                  // Navigator.pushNamed(context, "/signup");
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(seconds: 2),
                                  width: 150,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color:
                                          const Color.fromARGB(255, 2, 16, 53),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(134, 255, 255, 255),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),

                              // ElevatedButton(
                              //   child: Text("Login"),
                              //   style: TextButton.styleFrom(minimumSize: Size(150, 50)),
                              //   onPressed: () {
                              //   },
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      var roll = email.contains(RegExp(r'[0-9]'))
          ? await authService
              .logInWithEmailAndPassword(email, password)
              .then((value) async {
              if (value == true) {
                QuerySnapshot snapshot = await DatabaseService(
                        uid: FirebaseAuth.instance.currentUser!.uid)
                    .gettingUserData(email);
                //saving value to our sf
                await HelperFunction.saveUserLoggedInStatus(true);
                await HelperFunction.saveUserEmailSF(email);
                //await HelperFunction.saveUserNameSF(snapshot.docs[0]['Name']);
                await databaseService.storingStudentData();
                // ignore: use_build_context_synchronously
                nextScreenReplace(
                    context,
                    HomePage(
                      email: email,
                    ));
              } else {
                showSnackbar(context, Colors.red, value);
                setState(() {
                  _isLoading = false;
                });
              }
            })
          : await authService
              .logInTeacherWithEmailAndPassword(email, password)
              .then((value) async {
              if (value == true) {
                QuerySnapshot snap = await DatabaseService(
                        uid: FirebaseAuth.instance.currentUser!.uid)
                    .gettingTeacherData(email);
                await HelperFunction.saveTeacherLoggedInStatus(true);
                await HelperFunction.saveTeacherEmailSF(email);
                nextScreenReplace(context, TeacherHomePage());
              } else {
                showSnackbar(context, Colors.red, value);
                setState(() {
                  _isLoading = false;
                });
              }
            });
    }
  }
}




// colors: [Color(0xFF132248), Color.fromARGB(220, 2, 20, 52)],
// colors: [Color(0xFF132248), Color.fromARGB(230, 35, 9, 79)], purple texture
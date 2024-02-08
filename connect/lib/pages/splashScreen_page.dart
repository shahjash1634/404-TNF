import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // static String routeName = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(230, 5, 9, 79),
      // colors: [Color(0xFF132248), Color.fromARGB(230, 11, 15, 92)],
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Connect',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 60.0,
                        // backgroundColor: Color.fromARGB(230, 11, 15, 92),
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.5,
                      )),
              Text(
                'with a single tap',
                style: GoogleFonts.pattaya(
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w100),
              ),
            ]),
            Image.asset(
              'assets/images/logo3.png',
              height: 100.0,
              width: 100.0,
            )
          ],
        ),
      ),
    );
  }
}

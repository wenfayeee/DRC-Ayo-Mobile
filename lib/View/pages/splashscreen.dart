import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8F7F2),
              Color(0xFFFFFCF9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.2, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Image.asset(
                    'assets/images/Ayo_logo.png',
                    width: 245.22,
                    height: 162.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Event management made easy.',
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF1E3765),
                      fontWeight: FontWeight.w600,
                      // fontStyle: FontStyle.italic,
                      fontSize: 18),
                ),
                const SizedBox(height: 300.0),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 30.0, right: 30.0),
                  child: PushableButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    hslColor: HSLColor.fromColor(
                      const Color(0xFF1E3765),
                    ),
                    shadow: const BoxShadow(
                      color: Color(0xFF1E3765),
                    ),
                    height: 50,
                    elevation: 8,
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFFF8F7F2),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 130.0, left: 30.0, right: 30.0),
                  child: PushableButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    hslColor: HSLColor.fromColor(
                      const Color(0xFFB0C6D4),
                    ),
                    shadow: const BoxShadow(
                      color: Color(0xFFB0C6D4),
                    ),
                    height: 50,
                    elevation: 8,
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFFF8F9FC),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

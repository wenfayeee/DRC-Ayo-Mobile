import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
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
                  padding: const EdgeInsets.only(top: 95.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 387.51,
                    height: 256,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Event management made easy.',
                  style: GoogleFonts.poppins(
                      color: const Color(0xFFFFBA08),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                ),
                const SizedBox(height: 120.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PushableButton(
                    hslColor: HSLColor.fromColor(
                      const Color(0xFFF9E3FF),
                    ),
                    shadow: const BoxShadow(
                      color: Color(0xFFCDBBD2),
                    ),
                    height: 50,
                    elevation: 8,
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF939393),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
                // const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PushableButton(
                    hslColor: HSLColor.fromColor(
                      const Color(0xFFFFEE52),
                    ),
                    shadow: const BoxShadow(
                      color: Color(0xFFCDBF45),
                    ),
                    height: 50,
                    elevation: 8,
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF939393),
                          fontWeight: FontWeight.w500,
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

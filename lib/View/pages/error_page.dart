import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/error.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            bottom: 260,
            left: 167,
            child: Text(
              'Oh no!',
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3765)),
            ),
          ),
          Positioned(
            bottom: 170,
            left: 62,
            child: Text(
              'Something went wrong,\nplease try again.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3765)),
            ),
          ),
          const SizedBox(height: 200.0),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
              child: PushableButton(
                //return or reload previous page
                hslColor: HSLColor.fromColor(
                  const Color(0xffb2bbda),
                ),
                shadow: const BoxShadow(
                  color: Color(0xffa3aac3),
                ),
                height: 50,
                elevation: 8,
                child: Text(
                  'Try Again',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF8F7F2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

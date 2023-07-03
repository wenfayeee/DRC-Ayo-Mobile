import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';

class ForgotPwdPage extends StatefulWidget {
  const ForgotPwdPage({Key? key}) : super(key: key);

  @override
  State<ForgotPwdPage> createState() => _ForgotPwdPageState();
}

class _ForgotPwdPageState extends State<ForgotPwdPage> {
  final _resetPwdEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF8F7F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 245.22,
                    height: 162.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Forgot your password?',
                  style: GoogleFonts.poppins(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E3765),
                  ),
                ),
                // const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
                  child: Text(
                    'Enter your email address below and we will send you a password reset link.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: const Color(0xFF888789),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _resetPwdEmailController,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF888789),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 90.0),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: PushableButton(
                    onPressed: () {
                      // to implement function to send email for password reset
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
                      'Send Email',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF8F7F2),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: PushableButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
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
                      'Cancel',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF8F9FC),
                      ),
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

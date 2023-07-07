import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';
import '../../Functions/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ForgotPwdPage extends StatefulWidget {
  const ForgotPwdPage({Key? key}) : super(key: key);

  @override
  State<ForgotPwdPage> createState() => _ForgotPwdPageState();
}

Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
  try {
    final url = forget;
    final response = await http.post(Uri.parse(url), body: {'email': email});

    if (response.statusCode == 200) {
      showSnackBar(context, 'Reset password email sent successfully', true);
    } else {
      showSnackBar(context, 'Failed to send reset password email', false);
    }
  } catch (error) {
    showSnackBar(context, 'An error occurred', false);
  }
}

void showSnackBar(BuildContext context, String message, bool isSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ),
  );
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
                    'assets/images/Ayo_logo.png',
                    width: 245.22,
                    height: 162.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Forgot your password?',
                  style: GoogleFonts.poppins(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E3765),
                  ),
                ),
                // const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 15.0, left: 15.0, right: 15.0),
                  child: Text(
                    'Enter your email address below and we will send you a password reset link.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: const Color(0xffb2bbda),
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
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: PushableButton(
                    onPressed: () {
                      // to implement function to send email for password reset
                      // Retrieve the email entered by the user
                        final email = _resetPwdEmailController.text;

                        // Make the API call to send the password reset email
                        sendPasswordResetEmail(email, context);
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
                      top: 5.0, bottom: 10.0, left: 30.0, right: 30.0),
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

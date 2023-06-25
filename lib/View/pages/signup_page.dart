import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _newUserNameController = TextEditingController();
  final _newUserEmailController = TextEditingController();
  final _newUserPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFF5F6F2),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 245.22,
                    height: 162.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFA34EBB)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Create an account. It's free.",
                    style: GoogleFonts.poppins(
                        color: const Color(0xFF939393),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _newUserNameController,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Name',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC3C3C3),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _newUserEmailController,
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
                        color: Color(0xFFC3C3C3),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _newUserPasswordController,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Password',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC3C3C3),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Confirm Password',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC3C3C3),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
                  child: PushableButton(
                    hslColor: HSLColor.fromColor(
                      const Color(0xFFFFF493),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF939393),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate user to sign up page
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: Text(
                          'Login now.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFA34EBB),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}

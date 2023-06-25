import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  padding: const EdgeInsets.only(top: 90.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 245.22,
                    height: 162.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Login',
                  style: GoogleFonts.poppins(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFA34EBB)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Login to your account.',
                    style: GoogleFonts.poppins(
                        color: const Color(0xFF939393),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _emailController,
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
                const SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: "Password",
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
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot password? ',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF939393),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgotPwd');
                        },
                        child: Text(
                          'Reset now.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFA34EBB),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF939393),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF939393),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate user to sign up page
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          'Sign up now.',
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
        ),
      ),
    );
  }
}

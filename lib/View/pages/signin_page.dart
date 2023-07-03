import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:event_management_app/Functions/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pushable_button/pushable_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<bool> _emailValid = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _passwordValid = ValueNotifier<bool>(true);

  bool _isObscure = true;
  bool _isLoading = false;
  bool _isNotValidate = false;

  void loginUser() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": _emailController.text,
        "password": _passwordController.text
      };

      var response = await http.post(
        Uri.parse(login),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status(200)']) {
      } else {
        print('Something went wrong');
      }
    }
  }

  // void loginButtonPressed() {
  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text.trim();

  //   if (email.isEmpty || password.isEmpty) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text(
  //             'Error',
  //             style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  //           ),
  //           content: const Text('Please enter your email and password.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else if (!_emailValid.value && !_passwordValid.value) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: const Text(
  //               'Error',
  //               style:
  //                   TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  //             ),
  //             content: const Text('Please enter valid values for all fields.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16.0),
  //             ),
  //             elevation: 8.0,
  //           );
  //         });
  //   } else {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     Future.delayed(const Duration(seconds: 2), () {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       Navigator.of(context).pushNamed('/navigator');
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF8F7F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
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
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E3765),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Login to your account.',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF888789),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _emailValid,
                      builder: (context, isValid, _) {
                        return TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _emailValid.value =
                                  _formKey.currentState?.validate() ?? false;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          controller: _emailController,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            hintText: 'Email',
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF888789),
                            ),
                            alignLabelWithHint: true,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _passwordValid,
                      builder: (context, isValid, _) {
                        return TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _passwordValid.value =
                                  _formKey.currentState?.validate() ?? false;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          obscureText: _isObscure,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              child: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFFC3C3C3),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(12.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            hintStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF888789),
                            ),
                            alignLabelWithHint: true,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgotPwd');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 50.0),
                            child: Text(
                              'Forgot password?',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E3765),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: PushableButton(
                      // onPressed: _isLoading ? null : _loginButtonPressed,
                      onPressed: loginUser,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF8F7F2),
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
                            'Register now.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1E3765),
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
      ),
    );
  }
}

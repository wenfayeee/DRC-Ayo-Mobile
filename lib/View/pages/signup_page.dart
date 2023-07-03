import 'dart:convert';
import 'package:event_management_app/Functions/config.dart';
import 'package:event_management_app/View/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pushable_button/pushable_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _newUserNameController = TextEditingController();
  final _newUserEmailController = TextEditingController();
  final _newUserPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> _nameValid = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _emailValid = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _passwordValid = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _confirmPassword = ValueNotifier<bool>(true);

  bool _isObscure = true;
  bool _confirmIsObscure = true;
  bool _isLoading = false;
  bool _isNotValidate = false;

  // void registerUser() async {
  //   if (_newUserEmailController.text.isNotEmpty &&
  //       _newUserPasswordController.text.isNotEmpty) {
  //     var regBody = {
  //       "email": _newUserEmailController.text,
  //       "password": _newUserPasswordController.text
  //     };

  //     var response = await http.post(Uri.parse(register),
  //         // headers: {"Content-Type": "application/json"},
  //         body: jsonEncode(regBody));

  //     var jsonResponse = await jsonDecode(response.body);
  //     print(jsonResponse['status']);

  //     if (jsonResponse['status']) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => SignInPage()));
  //     } else {
  //       print("Something went wrong.");
  //     }
  //   } else {
  //     setState(() {
  //       _isNotValidate = true;
  //     });
  //   }
  // }

  void registerUser() async {
    if (_newUserEmailController.text.isNotEmpty &&
        _newUserPasswordController.text.isNotEmpty) {
      var regBody = {
        "email": _newUserEmailController.text,
        "password": _newUserPasswordController.text
      };

      var response = await http.post(
        Uri.parse(register),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: jsonEncode(regBody),
      );

      print(response.body);
      var jsonResponse = await jsonDecode(response.body);
      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      } else {
        print("Something went wrong.");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  void _signUpButtonPressed() {
    final name = _newUserNameController.text.trim();
    final email = _newUserEmailController.text.trim();
    final password = _newUserPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: const Text('Please fill in all the required fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
          );
        },
      );
    } else if (!_nameValid.value &&
        !_emailValid.value &&
        !_passwordValid.value &&
        !_confirmPassword.value) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: const Text('Please enter valid values for all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
          );
        },
      );
    } else {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed('/signin');
      });
    }
  }

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
                    padding: const EdgeInsets.only(top: 30.0),
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
                        color: const Color(0xFF1E3765)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Create an account. It's free.",
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF888789),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _nameValid,
                      builder: (context, isValid, _) {
                        return TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _nameValid.value =
                                  _formKey.currentState?.validate() ?? false;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            if (!RegExp(r"^[a-zA-Z ,.\'-]+$").hasMatch(value)) {
                              return 'Please enter a valid name';
                            }
                            if (value.length < 3) {
                              return 'Name must be more than 2 characters';
                            }
                            return null;
                          },
                          controller: _newUserNameController,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000)),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            hintText: 'Full Name',
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
                  const SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _emailValid,
                      builder: (context, value, child) {
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
                  const SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
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
                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              return 'Password must contain at least \none uppercase letter';
                            }
                            if (!value.contains(RegExp(r'[a-z]'))) {
                              return 'Password must contain at least \none lowercase letter';
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'Password must contain at least \none numeric digit';
                            }
                            if (!value.contains(RegExp(r'[!@#$%^&*]'))) {
                              return 'Password must contain at least \none special character';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                          obscureText: _isObscure,
                          controller: _newUserPasswordController,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            hintText: 'Password',
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
                  const SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _confirmPassword,
                      builder: (context, isValid, _) {
                        return TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _confirmPassword.value =
                                  _formKey.currentState?.validate() ?? false;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please re-enter your password';
                            }
                            if (value != _newUserPasswordController.text) {
                              return 'Password must be same as above';
                            }
                            return null;
                          },
                          controller: _confirmPasswordController,
                          obscureText: _confirmIsObscure,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            hintText: 'Confirm Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _confirmIsObscure = !_confirmIsObscure;
                                });
                              },
                              child: Icon(
                                _confirmIsObscure
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
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                    child: PushableButton(
                      // onPressed: _isLoading ? null : _signUpButtonPressed,
                      onPressed: () => registerUser(),
                      hslColor: HSLColor.fromColor(
                        const Color(0xFF1E3765),
                      ),
                      shadow: const BoxShadow(
                        color: Color(0xFF1E3765),
                      ),
                      height: 50,
                      elevation: 8,
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                            color: const Color(0xFFF8F7F2),
                            fontWeight: FontWeight.w600,
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
                          'Have an account? ',
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

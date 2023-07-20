// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:event_management_app/Functions/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
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

  @override
  void dispose() {
    super.dispose();
    _newUserNameController.dispose();
    _newUserEmailController.dispose();
    _newUserPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  void registerUser(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      var regBody = {
        "name": _newUserNameController.text,
        "email": _newUserEmailController.text,
        "password": _newUserPasswordController.text
      };

      try {
        var response = await http.post(
          Uri.parse(register),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: jsonEncode(regBody),
        );

        var jsonResponse =
            await jsonDecode(response.body) as Map<String, dynamic>;
        // var statusCode = jsonResponse['statusCode'] as int?;

        if (response.statusCode == 201) {
          return Dialogs.materialDialog(
            context: context,
            title: 'Success!',
            lottieBuilder: Lottie.asset('assets/animations/success.json',
                fit: BoxFit.contain),
            titleAlign: TextAlign.center,
            msg:
                "Congratulations! You have successfully created an account. Please sign in to proceed.",
            msgAlign: TextAlign.center,
            msgStyle: GoogleFonts.poppins(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000),
            ),
            color: const Color(0xFFF8F7F2),
            titleStyle: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000000),
            ),
            actions: [
              PushableButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                hslColor: HSLColor.fromColor(const Color(0xFF888789)),
                shadow: const BoxShadow(
                  color: Color(0xFF505457),
                ),
                height: 50,
                elevation: 8,
                child: Text(
                  'Ok',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF8F7F2),
                  ),
                ),
              ),
            ],
          );
        } else if (response.statusCode == 409) {
          return Dialogs.materialDialog(
            context: context,
            title: 'Email already exist.',
            lottieBuilder: Lottie.asset('assets/animations/error.json',
                fit: BoxFit.contain),
            titleAlign: TextAlign.center,
            msg: 'Please register with another email.',
            msgAlign: TextAlign.center,
            msgStyle: GoogleFonts.poppins(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000),
            ),
            color: const Color(0xFFF8F7F2),
            titleStyle: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000000),
            ),
            actions: [
              PushableButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                hslColor: HSLColor.fromColor(const Color(0xFF888789)),
                shadow: const BoxShadow(
                  color: Color(0xFF505457),
                ),
                height: 50,
                elevation: 8,
                child: Text(
                  'Try Again',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF8F7F2),
                  ),
                ),
              ),
            ],
          );
        } else {
          setState(() {
            _isNotValidate = true;
          });
        }
      } catch (error) {
        return Dialogs.materialDialog(
          context: context,
          title: 'An error occured.',
          lottieBuilder:
              Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: 'Please try again later.',
          msgAlign: TextAlign.center,
          msgStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000),
          ),
          color: const Color(0xFFF8F7F2),
          titleStyle: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF000000),
          ),
          actions: [
            PushableButton(
              onPressed: () {
                Navigator.pop(context);
              },
              hslColor: HSLColor.fromColor(const Color(0xFF888789)),
              shadow: const BoxShadow(
                color: Color(0xFF505457),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Try Again',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8F7F2),
                ),
              ),
            ),
          ],
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Image.asset(
                      'assets/images/Ayo_logo.png',
                      width: 245.22,
                      height: 162.0,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E3765)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 10.0, right: 10.0),
                    child: Text(
                      "Create an account. It's free.",
                      style: GoogleFonts.poppins(
                          color: const Color(0xffb2bbda),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 30.0, right: 30.0),
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
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            if (!RegExp(r"^[a-zA-Z ,.\'-]+$").hasMatch(value)) {
                              return 'Please enter a valid name';
                            }
                            if (value.length < 3) {
                              return 'Name must be more than 2 characters';
                            }
                            if (value.length > 31) {
                              return 'Name can be at most 30 characters';
                            }
                            if (value.contains(RegExp(
                                r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                              return 'Invalid input';
                            }
                            return null;
                          },
                          controller: _newUserNameController,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF000000)),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff8f9fc),
                            hintText: 'Full Name',
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            if (!value.contains('.com')) {
                              return 'Please enter a valid email address';
                            }
                            if (value.contains(RegExp(
                                r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                              return 'Invalid input';
                            }
                            return null;
                          },
                          controller: _newUserEmailController,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xff202926)),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff8f9fc),
                            hintText: 'Email',
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              return 'Password must contain at least \none uppercase letter';
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
                            if (value.length > 17) {
                              return 'Password can be at most 16 characters long only';
                            }
                            if (value.contains(RegExp(
                                r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                              return 'Invalid input';
                            }
                            return null;
                          },
                          obscureText: _isObscure,
                          controller: _newUserPasswordController,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF000000)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff8f9fc),
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              child: Icon(
                                _isObscure ? Iconsax.eye : Iconsax.eye_slash,
                                color: const Color(0xFFC3C3C3),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(12.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                            if (value == null || value.trim().isEmpty) {
                              return 'Please re-enter your password';
                            }
                            if (value != _newUserPasswordController.text) {
                              return 'Password must be same as above';
                            }
                            if (value.contains(RegExp(
                                r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                              return 'Invalid input';
                            }
                            if (value.contains(
                                RegExp(r'<(?:\/?[a-z]|[a-z]+\s*\/?)>'))) {
                              return 'Invalid input';
                            }
                            return null;
                          },
                          controller: _confirmPasswordController,
                          obscureText: _confirmIsObscure,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF000000)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff8f9fc),
                            hintText: 'Confirm Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _confirmIsObscure = !_confirmIsObscure;
                                });
                              },
                              child: Icon(
                                _confirmIsObscure
                                    ? Iconsax.eye
                                    : Iconsax.eye_slash,
                                color: const Color(0xFFC3C3C3),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(12.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                    child: PushableButton(
                      onPressed:
                          _isLoading ? null : () => registerUser(context),
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
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 10.0, left: 30.0, right: 30.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account? ',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff888789),
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
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2a4f92),
                              ),
                            ),
                          ),
                        ],
                      ),
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

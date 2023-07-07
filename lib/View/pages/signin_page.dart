import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:event_management_app/Functions/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pushable_button/pushable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        var reqBody = {
          "email": _emailController.text,
          "password": _passwordController.text
        };
        try {
          var response = await http.post(
            Uri.parse(login),
            headers: {
              "Content-Type": "application/json; charset=utf-8",
            },
            body: jsonEncode(reqBody),
          );
          var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
          var statusCode = jsonResponse['statusCode'] as int?;

          if (response.statusCode == 200) {
            // Successful authentication
            var token = jsonResponse['token'] as String?;
            print("$token");
            // Store token locally
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token!);
            Navigator.pushNamed(context, '/navigator');
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text("You're logged as {widget.email}"),
            //     backgroundColor: Colors.green,
            //   ),
            // );
          } else if (response.statusCode == 401) {
            // Invalid password
            print('Invalid password');
          } else if (response.statusCode == 404) {
            // User not found
            print('User not found');
          } else {
            print('Something went wrong');
          }
        } catch (error) {
          print('Error: $error');
        }
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
                    padding: const EdgeInsets.only(top: 90.0),
                    child: Image.asset(
                      'assets/images/Ayo_logo.png',
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
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: Text(
                      'Login to your account.',
                      style: GoogleFonts.poppins(
                        color: const Color(0xffb2bbda),
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
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
                            fontWeight: FontWeight.w300,
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
                  const SizedBox(height: 0.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
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
                            fontWeight: FontWeight.w300,
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
                  const SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            //test
                            Navigator.pushNamed(context, '/forgotPwd');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Text(
                              'Forgot password?',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E3765),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 200.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: PushableButton(
                      // onPressed: _isLoading ? null : _loginButtonPressed,
                      onPressed: () => loginUser(),
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
                          fontSize: 20,
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
                            fontSize: 15,
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
                              fontSize: 15,
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

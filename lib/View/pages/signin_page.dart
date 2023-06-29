import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _loginButtonPressed() {
    if (_emailValid.value && _passwordValid.value) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed('/navigator');
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
                      onPressed: _isLoading ? null : _loginButtonPressed,
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

// class _SignInPageState extends State<SignInPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   final ValueNotifier<bool> _emailValid = ValueNotifier<bool>(true);
//   final ValueNotifier<bool> _passwordValid = ValueNotifier<bool>(true);

//   bool _isObscure = true;
//   bool _isLoading = false;

//   void _loginButtonPressed() {
//     if (_emailValid.value && _passwordValid.value) {
//       setState(() {
//         _isLoading = true;
//       });

//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           _isLoading = false;
//         });
//         Navigator.of(context).pushNamed('/navigator');
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: const Color(0xFFF8F7F2),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 90.0),
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     width: 245.22,
//                     height: 162.0,
//                   ),
//                 ),
//                 const SizedBox(height: 15.0),
//                 Text(
//                   'Login',
//                   style: GoogleFonts.poppins(
//                     fontSize: 22.0,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF1E3765),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     'Login to your account.',
//                     style: GoogleFonts.poppins(
//                       color: const Color(0xFF888789),
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40.0),
//                 Form(
//                   key: _formKey,
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 10.0,
//                       left: 30.0,
//                       right: 30.0,
//                     ),
//                     child: ValueListenableBuilder<bool>(
//                       valueListenable: _emailValid,
//                       builder: (context, isValid, _) {
//                         return TextFormField(
//                           onChanged: (value) {
//                             setState(() {
//                               _emailValid.value =
//                                   _formKey.currentState?.validate() ?? false;
//                             });
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             if (!value.contains('@')) {
//                               return 'Please enter a valid email address';
//                             }
//                             return null;
//                           },
//                           controller: _emailController,
//                           keyboardType: TextInputType.text,
//                           style: GoogleFonts.poppins(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w500,
//                             color: const Color(0xFF000000),
//                           ),
//                           decoration: const InputDecoration(
//                             filled: true,
//                             fillColor: Color(0xFFFFFFFF),
//                             hintText: 'Email',
//                             contentPadding: EdgeInsets.all(12.0),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Color(0xFFC3C3C3)),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                             hintStyle: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xFF888789),
//                             ),
//                             alignLabelWithHint: true,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 10.0,
//                     left: 30.0,
//                     right: 30.0,
//                   ),
//                   child: TextFormField(
//                     controller: _passwordController,
//                     obscureText: _isObscure,
//                     keyboardType: TextInputType.text,
//                     style: GoogleFonts.poppins(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0xFF000000),
//                     ),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color(0xFFFFFFFF),
//                       hintText: "Password",
//                       suffixIcon: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _isObscure = !_isObscure;
//                           });
//                         },
//                         child: Icon(
//                           _isObscure ? Icons.visibility : Icons.visibility_off,
//                           color: const Color(0xFFC3C3C3),
//                         ),
//                       ),
//                       contentPadding: const EdgeInsets.all(12.0),
//                       border: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFFC3C3C3)),
//                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                       ),
//                       hintStyle: const TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xFF888789),
//                       ),
//                       alignLabelWithHint: true,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/forgotPwd');
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 50.0),
//                           child: Text(
//                             'Forgot password?',
//                             style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0xFF1E3765),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 50.0),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 10.0,
//                     bottom: 10.0,
//                     left: 30.0,
//                     right: 30.0,
//                   ),
//                   child: PushableButton(
//                     onPressed: _isLoading ? null : _loginButtonPressed,
//                     hslColor: HSLColor.fromColor(
//                       const Color(0xFF1E3765),
//                     ),
//                     shadow: const BoxShadow(
//                       color: Color(0xFF1E3765),
//                     ),
//                     height: 50,
//                     elevation: 8,
//                     child: Text(
//                       'Login',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: const Color(0xFFF8F7F2),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Don't have an account? ",
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: const Color(0xFF939393),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // Navigate user to sign up page
//                           Navigator.pushNamed(context, '/signup');
//                         },
//                         child: Text(
//                           'Register now.',
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: const Color(0xFF1E3765),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

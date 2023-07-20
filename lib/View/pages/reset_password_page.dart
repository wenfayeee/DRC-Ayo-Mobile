// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:pushable_button/pushable_button.dart';
import '../../Functions/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
  }

  void resetPassword() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');

    if (storedToken != null) {
      final response = await http.put(
        Uri.parse(update), // Backend endpoint URL from config.dart
        headers: {
          'Authorization': 'Bearer $storedToken',
        },
        body: {
          'currentPassword': oldPassword,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        // Password update successful
        return Dialogs.materialDialog(
          context: context,
          title: 'Success!',
          lottieBuilder: Lottie.asset('assets/animations/success.json',
              fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: "Great! You have successfully changed your password.",
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
                Navigator.pushReplacementNamed(context, '/navigator');
              },
              hslColor: HSLColor.fromColor(const Color(0xFF888789)),
              shadow: const BoxShadow(
                color: Color(0xFF505457),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8F7F2),
                ),
              ),
            ),
          ],
        );
      } else if (response.statusCode == 401) {
        // Password update failed
        return Dialogs.materialDialog(
          context: context,
          title: 'Invalid current password.',
          lottieBuilder:
              Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: 'Please try again with a valid current password.',
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
      } else if (response.statusCode == 500) {
        // Password update failed
        return Dialogs.materialDialog(
          context: context,
          title: 'Failed to update password.',
          lottieBuilder:
              Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: 'Please try again.',
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15.0),
                Text(
                  'Reset Password',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF6B5F4A),
                  ),
                ),
                const SizedBox(height: 50.0),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Enter your old password and new password below',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                      color: Color(0xFF1E3765),
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    if (value.length > 17) {
                      return 'Password can be at most 16 characters long only';
                    }
                    if (value.contains(
                        RegExp(r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                      return 'Invalid input';
                    }
                    return null;
                  },
                  controller: _oldPasswordController,
                  obscureText: !_isOldPasswordVisible,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    hintText: 'Enter Old Password',
                    contentPadding: const EdgeInsets.all(12.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF888789),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isOldPasswordVisible ? Iconsax.eye_slash : Iconsax.eye,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isOldPasswordVisible = !_isOldPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your new password';
                    }
                    if (value == _oldPasswordController.text) {
                      return 'Password cannot be the same as above';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    if (value.length > 17) {
                      return 'Password can be at most 16 characters long only';
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
                    if (value.contains(
                        RegExp(r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                      return 'Invalid input';
                    }
                    return null;
                  },
                  controller: _newPasswordController,
                  obscureText: !_isNewPasswordVisible,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    hintText: 'Enter New Password',
                    contentPadding: const EdgeInsets.all(12.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF888789),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isNewPasswordVisible ? Iconsax.eye_slash : Iconsax.eye,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isNewPasswordVisible = !_isNewPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 200.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PushableButton(
                      onPressed: () {
                        // Handle reset password logic
                        if (_formKey.currentState!.validate()) {
                          resetPassword();
                        }
                      },
                      hslColor: HSLColor.fromColor(const Color(0xFF1E3765)),
                      shadow: const BoxShadow(
                        color: Color(0xFF1E3765),
                      ),
                      height: 50.0,
                      elevation: 8.0,
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF8F7F2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    PushableButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/navigator');
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

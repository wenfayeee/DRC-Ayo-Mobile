import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';

class ResetProfilePage extends StatefulWidget {
  @override
  _ResetProfilePageState createState() => _ResetProfilePageState();
}

class _ResetProfilePageState extends State<ResetProfilePage> {
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Password',
                  style: GoogleFonts.poppins(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF6B5F4A),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
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
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF888789),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isOldPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                const SizedBox(height: 20),
                TextFormField(
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
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF888789),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isNewPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: !_isConfirmPasswordVisible,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    hintText: 'Confirm New Password',
                    contentPadding: const EdgeInsets.all(12.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF888789),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                PushableButton(
                  onPressed: () {
                    // Handle reset password logic
                  },
                  hslColor: HSLColor.fromColor(const Color(0xFF1E3765)),
                  shadow: const BoxShadow(
                    color: Color(0xFF1E3765),
                  ),
                  height: 50,
                  elevation: 8,
                  child: Text(
                    'Confirm',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF8F7F2),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
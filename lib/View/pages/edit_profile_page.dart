import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatelessWidget {
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
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Edit Profile',
            style: GoogleFonts.poppins(
              fontSize: 28.0,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF6B5F4A),
            ),
          ),
        ),
      ),
    );
  }
}

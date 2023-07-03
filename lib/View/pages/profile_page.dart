import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(
                "User Account",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF6B5F4A),
                ),
              ),
            ),
            Center(
              child: Text('User Profile Page'),
            ),
          ],
        ),
      ),
    );
  }
}

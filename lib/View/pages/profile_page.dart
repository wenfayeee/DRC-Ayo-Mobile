// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _name = '';
  late String _email = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showLogOutPrompt() async {
    return Dialogs.materialDialog(
      context: context,
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      title: 'Are you sure you want to logout?',
      titleAlign: TextAlign.center,
      color: const Color(0xFFB2BBDA),
      titleStyle: GoogleFonts.poppins(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF505457),
      ),
      actions: [
        Container(
          child: PushableButton(
            onPressed: () {
              // Handle 'Cancel' button logic
              Navigator.pop(context);
            },
            hslColor: HSLColor.fromColor(const Color(0xFFF8F9FC)),
            shadow: const BoxShadow(
              color: Color(0xFFF8F9FC),
            ),
            height: 50,
            elevation: 8,
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF888789),
              ),
            ),
          ),
        ),
        Container(
          child: PushableButton(
            onPressed: () {
              // Handle 'Delete' button logic
              _logout();
            },
            hslColor: HSLColor.fromColor(const Color(0xFF2A4F92)),
            shadow: const BoxShadow(
              color: Color(0xFF2A4F92),
            ),
            height: 50,
            elevation: 8,
            child: Text(
              'Confirm',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF8F9FC),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToResetPassword() {
    Navigator.pushNamed(context, '/resetPassword');
  }

  void _logout() async {
    // Clear the authentication token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Navigate back to the sign-in page
    Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFFFCF9),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22.0, left: 25.0),
                  child: Text(
                    "User Account",
                    style: GoogleFonts.poppins(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF6B5F4A),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 90,
                backgroundColor: const Color.fromARGB(255, 199, 194, 172),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/Ayo_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Center(
                child: Container(
                  width: 320,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(57, 174, 153, 77),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xFFB3AE99), width: 3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _name,
                                style: const TextStyle(
                                  color: Color(0xFF1E3765),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.email,
                                color: Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _email,
                                style: const TextStyle(
                                  color: Color(0xFF1E3765),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ProfileOption(
              title: 'Reset Password',
              icon: Iconsax.key_square,
              onPressed: _navigateToResetPassword,
            ),
            const SizedBox(height: 30),
            ProfileOption(
              title: 'Logout',
              icon: Iconsax.logout,
              onPressed: () {
                _showLogOutPrompt();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;

  const ProfileOption({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

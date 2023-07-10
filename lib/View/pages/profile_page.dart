import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePickerPlatform _picker = ImagePickerPlatform.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_picker is ImagePickerAndroid) {
      (_picker as ImagePickerAndroid).useAndroidPhotoPicker = true;
    }

    final pickedImage = await _picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _navigateToEditProfile() {
    Navigator.pushNamed(context, '/eventDetails');
  }

  void _navigateToResetPassword() {
    Navigator.pushNamed(context, '/resetPassword');
  }

  void _navigateToEventHistory() {
    Navigator.pushNamed(context, '/eventHist');
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(
                "User Account",
                style: GoogleFonts.poppins(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF6B5F4A),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: const Color(0xFFB3AE99),
                  child: CircleAvatar(
                    radius: 85,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Center(
                child: Container(
                  width: 276,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(57, 174, 153, 77),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xFFB3AE99), width: 3),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  color: Color(0xFF1E3765),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.email,
                                color: Colors.black,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'johndoe@mail.com',
                                style: TextStyle(
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
            const SizedBox(height: 20),
            ProfileOption(
              title: 'Edit Profile',
              icon: Icons.edit,
              onPressed: _navigateToEditProfile,
            ),
            const SizedBox(height: 20),
            ProfileOption(
              title: 'Reset Password',
              icon: Icons.vpn_key,
              onPressed: _navigateToResetPassword,
            ),
            const SizedBox(height: 20),
            ProfileOption(
              title: 'Event History',
              icon: Icons.calendar_today,
              onPressed: _navigateToEventHistory,
            ),
            const SizedBox(height: 20),
            ProfileOption(
              title: 'Logout',
              icon: Icons.logout,
              onPressed: _logout,
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

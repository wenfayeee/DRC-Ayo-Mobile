import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  final String token;
  const EditProfilePage({required this.token, Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? token;
  String? email;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print('hi' + '$widget');
    super.initState();
    getTokenFromSharedPrefs();
  }

  void getTokenFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');

    if (storedToken != null) {
      setState(() {
        token = storedToken;
        print(token);
      });
      decodeToken();
    }
  }

  void decodeToken() {
    Map<String, dynamic>? jwtDecodedToken;
    if (token != null) {
      jwtDecodedToken = JwtDecoder.decode(token!);
      if (jwtDecodedToken.containsKey('email')) {
        email = jwtDecodedToken['email'] as String?;
        print(email);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFFFCF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 22.0, left: 25.0),
                        child: Text(
                          'Edit Profile',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF6B5F4A),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 22.0, right: 25.0, bottom: 2.0, left: 10.0),
                        child: AnimatedButton(
                          height: 50,
                          width: 100,
                          text: 'Save',
                          isReverse: true,
                          selectedTextColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          transitionType: TransitionType.LEFT_TO_RIGHT,
                          backgroundColor: const Color(0xFFB3AE99),
                          selectedBackgroundColor: const Color(0xFF6B5F4A),
                          borderColor: Colors.white,
                          borderRadius: 50,
                          borderWidth: 2,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          onPress: () {},
                        ),
                      ),
                    ],
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

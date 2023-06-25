import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPwdPage extends StatefulWidget {
  const ForgotPwdPage({Key? key}) : super(key: key);

  @override
  State<ForgotPwdPage> createState() => _ForgotPwdPageState();
}

class _ForgotPwdPageState extends State<ForgotPwdPage> {
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Reset password page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:event_management_app/View/pages/error_page.dart';
import 'package:event_management_app/View/pages/home_page.dart';
import 'package:event_management_app/View/pages/splashscreen.dart';
import 'package:event_management_app/View/widgets/test_bottomnavbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenPage(),
    );
  }
}

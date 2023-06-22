import 'package:event_management_app/View/pages/account_page.dart';
import 'package:event_management_app/View/pages/error_page.dart';
import 'package:event_management_app/View/pages/events_page.dart';
import 'package:event_management_app/View/pages/bottom_nav_placeholder.dart';
import 'package:event_management_app/View/pages/home_page.dart';
import 'package:event_management_app/View/pages/signin_page.dart';
import 'package:event_management_app/View/pages/signup_page.dart';
import 'package:event_management_app/View/pages/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => BottomNavCubit(0),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       primarySwatch: Colors.grey,
    //     ),
    //     home: Scaffold(
    //       body: HomePage(),
    //     ),
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const BottomNavPlaceholder(),
      routes: {
        '/splash': (context) => SplashScreenPage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/events': (context) => const EventsPage(),
        '/account': (context) => const AccountPage(),
        '/error': (context) => const ErrorPage(),
      },
    );
  }
}

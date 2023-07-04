import 'package:event_management_app/View/pages/profile_page.dart';
import 'package:event_management_app/View/pages/error_page.dart';
import 'package:event_management_app/View/pages/create_event_page.dart';
import 'package:event_management_app/View/pages/reset_password_page.dart';
import 'package:event_management_app/View/pages/home_page.dart';
import 'package:event_management_app/View/pages/signin_page.dart';
import 'package:event_management_app/View/pages/signup_page.dart';
import 'package:event_management_app/View/pages/splashscreen.dart';
import 'package:event_management_app/View/pages/edit_profile_page.dart';
import 'package:event_management_app/View/pages/event_history_page.dart';
import 'package:event_management_app/View/pages/reset_profile_page.dart';
import 'package:event_management_app/View/widgets/bottom_nav_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MainApp(
    token: prefs.getString('token'),
  ));
}

class MainApp extends StatelessWidget {
  final token;
  const MainApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Poppins'),
      home: const SignInPage(),
      // home: token != null && !JwtDecoder.isExpired(token)
      //     ? HomePage(token: token)
      //     : const SignInPage(),
      routes: {
        '/splash': (context) => const SplashScreenPage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/create': (context) => const CreateEventPage(),
        '/profile': (context) => ProfilePage(),
        '/forgotPwd': (context) => const ForgotPwdPage(),
        '/eventHist': (context) => EventHistoryPage(),
        '/editProfile': (context) => EditProfilePage(),
        '/resetProfile': (context) => ResetProfilePage(),
        '/navigator': (context) => const BottomNavPlaceholder(),
        '/error': (context) => const ErrorPage(),
      },
    );
  }
}

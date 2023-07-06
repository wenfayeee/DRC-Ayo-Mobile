import 'package:event_management_app/View/pages/profile_page.dart';
import 'package:event_management_app/View/pages/error_page.dart';
import 'package:event_management_app/View/pages/create_event_page.dart';
import 'package:event_management_app/View/pages/forgot_password_page.dart';
import 'package:event_management_app/View/pages/home_page.dart';
import 'package:event_management_app/View/pages/signin_page.dart';
import 'package:event_management_app/View/pages/signup_page.dart';
import 'package:event_management_app/View/pages/splashscreen.dart';
import 'package:event_management_app/View/pages/edit_profile_page.dart';
import 'package:event_management_app/View/pages/event_history_page.dart';
import 'package:event_management_app/View/pages/reset_password_page.dart';
import 'package:event_management_app/View/widgets/bottom_nav_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isTokenValid(String? token) {
  if (token == null) {
    return false;
  }

  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  int? expirationTimestamp = decodedToken['exp'];

  if (expirationTimestamp != null) {
    DateTime expirationDate =
        DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
    DateTime currentDate = DateTime.now();
    return currentDate.isBefore(expirationDate);
  }
  print("$expirationTimestamp");
  return false;
}

void main() async {
  print("object");
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  print("$token");

  runApp(MainApp(
    token: isTokenValid(token) ? token : null,
  ));
}

class MainApp extends StatefulWidget {
  final String? token;

  const MainApp({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late String homeRoute;

  @override
  void initState() {
    super.initState();
    homeRoute = widget.token != null && isTokenValid(widget.token!)
        ? '/navigator'
        : '/signin';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Poppins'),
      initialRoute: homeRoute,
      routes: {
        // Your other routes
        '/splash': (context) => const SplashScreenPage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => HomePage(token: widget.token),
        '/create': (context) => CreateEventPage(token: widget.token!),
        '/profile': (context) => const ProfilePage(),
        '/forgotPwd': (context) => const ForgotPwdPage(),
        '/eventHist': (context) => EventHistoryPage(),
        '/editProfile': (context) => EditProfilePage(),
        '/resetPassword': (context) => ResetPasswordPage(),
        '/navigator': (context) => BottomNavPlaceholder(token: widget.token),
        '/error': (context) => const ErrorPage(),
      },
    );
  }
}


// void main() async {
//   print("object");
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString('token');
//   print("$token");
//   bool tokenIsValid = false;

// if (token != null) {
//   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
//   int? expirationTimestamp = decodedToken['exp'];

//   if (expirationTimestamp != null) {
//     DateTime expirationDate =
//         DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
//     DateTime currentDate = DateTime.now();
//     tokenIsValid = currentDate.isBefore(expirationDate);
//   }
// }
//   runApp(MainApp(
//     token: tokenIsValid ? token : null,
//   ));
// }

// class MainApp extends StatelessWidget {
//   final String? token;

//   const MainApp({
//     Key? key,
//     this.token,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Poppins'),
//       home: token != null ? HomePage(token: token!) : const SignInPage(),
//       // home: const SignInPage(),
//       // home: token != null && !JwtDecoder.isExpired(token)
//       //     ? HomePage(token: token)
//       //     : const SignInPage(),
//       routes: {
//         '/splash': (context) => const SplashScreenPage(),
//         '/signin': (context) => const SignInPage(),
//         '/signup': (context) => const SignUpPage(),
//         '/home': (context) => HomePage(token: token),
//         '/create': (context) => const CreateEventPage(),
//         '/profile': (context) => const ProfilePage(),
//         '/forgotPwd': (context) => const ForgotPwdPage(),
//         '/navigator': (context) => BottomNavPlaceholder(token: token!),
//         '/error': (context) => const ErrorPage(),
//       },
//     );
//   }
// }

import 'package:event_management_app/View/pages/event_details_page.dart';
import 'package:event_management_app/View/pages/guest_rsvp_page.dart';
import 'package:event_management_app/View/pages/profile_page.dart';
import 'package:event_management_app/View/pages/create_event_page.dart';
import 'package:event_management_app/View/pages/forgot_password_page.dart';
import 'package:event_management_app/View/pages/home_page.dart';
import 'package:event_management_app/View/pages/signin_page.dart';
import 'package:event_management_app/View/pages/signup_page.dart';
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
  return false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

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
    homeRoute = widget.token != null && isTokenValid(widget.token)
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
        // Other page routes
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => HomePage(token: widget.token ?? ''),
        '/create': (context) => CreateEventPage(token: widget.token ?? ''),
        '/profile': (context) => const ProfilePage(),
        '/forgotPwd': (context) => const ForgotPwdPage(),
        '/resetPassword': (context) => const ResetPasswordPage(),
        '/eventDetailsInvited': (context) => EventDetailsPage(
              token: widget.token ?? '',
              eventCode: '',
              isHost: false,
              isInvited: true,
            ),
        '/eventDetailsHosted': (context) => EventDetailsPage(
              token: widget.token ?? '',
              eventCode: '',
              isHost: true,
              isInvited: false,
            ),
        '/rsvpDetails': (context) => GuestRSVPPage(
              token: widget.token,
              eventCode: '',
            ),
        '/navigator': (context) =>
            BottomNavPlaceholder(token: widget.token ?? ''),
      },
    );
  }
}

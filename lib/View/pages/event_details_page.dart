import 'dart:convert';

// import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:event_management_app/Functions/config.dart';
import 'package:event_management_app/View/widgets/bottom_nav_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDetailsPage extends StatefulWidget {
  final String? token;
  const EventDetailsPage({required this.token, Key? key}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String? token;
  String? email;
  final _formKey = GlobalKey<FormState>();
  final _eventCodeController = TextEditingController();
  final _rsvpStatusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTokenFromSharedPrefs();
    print('EventDetailsPage init');
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
      }
    }
  }

  // Map<String, dynamic>? decodeToken() {
  //   if (token != null) {
  //     return JwtDecoder.decode(token!);
  //   }
  //   return null;
  // }

  void addToCalendar() async {
    // To be implemented
  }

  void showRSVPPrompt() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_eventCodeController.text.isNotEmpty &&
          _rsvpStatusController.text.isNotEmpty) {
        var regBody = {
          "event_code": _eventCodeController.text,
          "rsvp_status": _rsvpStatusController.text,
          "email": email,
        };

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('RSVP'),
              content: const Text('Add RSVP'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await addRSVP(regBody);
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> addRSVP(Map<String, dynamic> regBody) async {
    try {
      var response = await http.post(
        Uri.parse(addRSVP as String),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(regBody),
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var statusCode = jsonResponse['statusCode'] as int?;

      print(regBody);
      if (response.statusCode == 200) {
        _eventCodeController.clear();
        _rsvpStatusController.clear();
        print('RSVP added successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('RSVP added successfully'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, '/home');
      } else if (response.statusCode == 500) {
        print('Failed to add RSVP');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add RSVP'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print('Something went wrong');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.orange,
          ),
        );
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, '/error');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // void testAdd() {
  //   final Event event = Event(
  //     title: 'Study group',
  //     description: 'Kononnya study la',
  //     startDate: DateTime(2023, 7, 9, 18, 30),
  //     endDate: DateTime(2023, 7, 9, 22, 30),
  //     androidParams: const AndroidParams(
  //       emailInvites: [
  //         'farhah@besquare.com.my',
  //         'asyura@besquare.com.my',
  //         'lubega@besquare.com.my',
  //         'haziq@besquare.com.my',
  //         'munnfaye@besquare.com.my'
  //       ],
  //     ),
  //   );
  //   Add2Calendar.addEvent2Cal(event);
  // }

  @override
  void dispose() {
    print('EventDetailsPage dispose');
    super.dispose();
    _eventCodeController.dispose();
    _rsvpStatusController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Details',
              style: GoogleFonts.poppins(
                fontSize: 28.0,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF6B5F4A),
              ),
            ),
            const SizedBox(height: 30),
            const Expanded(
              child: BuildEventCard(),
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Would you attend this event?',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B5F4A),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PushableButton(
                        onPressed: () {
                          // Handle 'RSVP' button logic
                          showRSVPPrompt();
                        },
                        hslColor: HSLColor.fromColor(const Color(0xFFB2BBDA)),
                        shadow: const BoxShadow(
                          color: Color(0xFF1E3765),
                        ),
                        height: 50,
                        elevation: 8,
                        child: Text(
                          'RSVP',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E3765),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: PushableButton(
                        onPressed: () {
                          // Handle 'Cancel' button logic
                          Navigator.pop(context);
                        },
                        hslColor: HSLColor.fromColor(const Color(0xFFB3AE99)),
                        shadow: const BoxShadow(
                          color: Color(0xFF554C3C),
                        ),
                        height: 50,
                        elevation: 8,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF554C3C),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavPlaceholder(token: token),
    );
  }
}

class BuildEventCard extends StatelessWidget {
  const BuildEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB3AE99),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:event_management_app/View/widgets/bottom_nav_placeholder.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:pushable_button/pushable_button.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EventDetailsPage extends StatefulWidget {
//   const EventDetailsPage({Key? key}) : super(key: key);

//   @override
//   State<EventDetailsPage> createState() => _EventDetailsPage();
// }

// class _EventDetailsPage extends State<EventDetailsPage> {
//   String? token;
//   String? email;

//   @override
//   void initState() {
//     super.initState();
//     getTokenFromSharedPrefs();
//     print('EventDetailsPage init');
//   }

//   void getTokenFromSharedPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? storedToken = prefs.getString('token');

//     if (storedToken != null) {
//       setState(() {
//         token = storedToken;
//         print(token);
//       });
//       decodeToken();
//     }
//   }

//   void decodeToken() {
//     Map<String, dynamic>? jwtDecodedToken;
//     if (token != null) {
//       jwtDecodedToken = JwtDecoder.decode(token!);
//       if (jwtDecodedToken.containsKey('email')) {
//         email = jwtDecodedToken['email'] as String?;
//       }
//     }
//   }

//   @override
//   void dispose() {
//     print('EventDetailsPage dispose');
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           // IconButton(
//           //   icon: const Icon(Icons.close),
//           //   onPressed: () {
//           //     Navigator.pushNamed(context, '/home');
//           //   },
//           // ),
//           IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 60, 20, 120),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Event Details',
//               style: GoogleFonts.poppins(
//                 fontSize: 28.0,
//                 fontWeight: FontWeight.w800,
//                 color: const Color(0xFF6B5F4A),
//               ),
//             ),
//             const SizedBox(height: 30),
//             const Expanded(
//               child: BuildEventCard(),
//             ),
//             const SizedBox(height: 30),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Would you attend this event?',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF6B5F4A),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: PushableButton(
//                         onPressed: () {
//                           // Handle 'Yes' button logic
//                         },
//                         hslColor: HSLColor.fromColor(const Color(0xFFB2BBDA)),
//                         shadow: const BoxShadow(
//                           color: Color(0xFF1E3765),
//                         ),
//                         height: 50,
//                         elevation: 8,
//                         child: Text(
//                           'Yes',
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xFF1E3765),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     Expanded(
//                       child: PushableButton(
//                         onPressed: () {
//                           // Handle 'No' button logic
//                         },
//                         hslColor: HSLColor.fromColor(const Color(0xFFB3AE99)),
//                         shadow: const BoxShadow(
//                           color: Color(0xFF554C3C),
//                         ),
//                         height: 50,
//                         elevation: 8,
//                         child: Text(
//                           'No',
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xFF554C3C),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavPlaceholder(token: token),
//     );
//   }
// }

// class BuildEventCard extends StatelessWidget {
//   const BuildEventCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFB3AE99),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 255, 255, 255),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

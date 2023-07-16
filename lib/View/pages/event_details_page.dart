// import 'dart:convert';

// import 'package:add_2_calendar/add_2_calendar.dart';
// import 'package:device_calendar/device_calendar.dart';
// import 'package:event_management_app/Functions/config.dart';
// import 'package:event_management_app/Model/event_model.dart';
// // import 'package:event_management_app/View/widgets/bottom_nav_placeholder.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:pushable_button/pushable_button.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:syncfusion_flutter_calendar/calendar.dart';

// class EventDetailsPage extends StatefulWidget {
//   final String? token;
//   final String eventCode;

//   const EventDetailsPage(
//       {required this.token, Key? key, required this.eventCode})
//       : super(key: key);

//   @override
//   State<EventDetailsPage> createState() => _EventDetailsPageState();
// }

// class _EventDetailsPageState extends State<EventDetailsPage> {
//   String? token;
//   String? email;
//   String? eventCode;
//   final _formKey = GlobalKey<FormState>();
//   final _eventCodeController = TextEditingController();
//   final _rsvpStatusController = TextEditingController();

//   List<InvitedEventDetails> invitedEventDetails = [];
//   List<HostedEventDetails> hostedEventDetails = [];

//   @override
//   void initState() {
//     print('hi' + '$widget');
//     super.initState();
//     getTokenFromSharedPrefs();
//     print('EventDetailsPage init');
//     decodeToken();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     fetchEventDetails(
//         widget.eventCode); // Access the event code from widget object
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
//     if (widget.token != null) {
//       jwtDecodedToken = JwtDecoder.decode(widget.token!);
//       if (jwtDecodedToken!.containsKey('email')) {
//         email = jwtDecodedToken['email'] as String?;
//       }
//     }
//   }

//   void fetchEventDetails(String eventCode) async {
//     print(("this is valid token $token"));
//     try {
//       var response = await http.get(
//         Uri.parse('$getEventByEventCode$eventCode'),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token"
//         },
//       );
//       print("whats up : $eventCode");
//       print(token);
//       print(response.statusCode);

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         print("is event true");
//         print(response.body);
//         print("end of event");
//         // Parse the response and store the event details
//         // Update your widget state accordingly
//       } else {
//         print("event fail");
//         print('Failed to fetch event details');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }

//   // Map<String, dynamic>? decodeToken() {
//   //   if (token != null) {
//   //     return JwtDecoder.decode(token!);
//   //   }
//   //   return null;
//   void showInvitedEventDetails() async {
//     Future<List<InvitedEventDetails>> getInvitedEventDetails() async {
//       try {
//         var response = await http.get(
//           Uri.parse('$getEventByInviteeEmail$email'),
//           headers: {
//             "Content-Type": "application/json",
//             "Authorization": "Bearer $token"
//           },
//         );

//         print('Response status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         if (response.statusCode == 200) {
//           var jsonResponse = jsonDecode(response.body) as List<dynamic>;
//           List<InvitedEventDetails> invitedEventDetails =
//               jsonResponse.map((eventData) {
//             return InvitedEventDetails(
//                 eventId: eventData['event_id'],
//                 eventName: eventData['event_name'],
//                 eventDate: eventData['event_date'],
//                 eventTime: eventData['event_time'],
//                 eventAddress: eventData['event_address'],
//                 eventDetail: eventData['event_detail'],
//                 eventRsvpBeforeDate: eventData['event_rsvp_before_date'],
//                 eventRsvpBeforeTime: eventData['event_rsvp_before_time'],
//                 eventCode: eventData['event_code']);
//           }).toList();
//           return invitedEventDetails;
//         } else if (response.statusCode == 404) {
//           print('No event details found');
//           return [];
//         } else {
//           print('Failed to fetch invited event details');
//           return [];
//         }
//       } catch (error) {
//         print('Error: $error');
//         return [];
//       }
//     }

//     // Call the function to get invited events' details
//     invitedEventDetails = await getInvitedEventDetails();
//   }

//   void showHostedEventDetails() async {
//     Future<List<HostedEventDetails>> getHostedEventDetails() async {
//       try {
//         var response = await http.get(
//           Uri.parse('$getEventByEmail$email'),
//           headers: {
//             "Content-Type": "application/json",
//             "Authorization": "Bearer $token"
//           },
//         );
//         print('Response status code: ${response.statusCode}');
//         print('Reponse body: ${response.body}');
//         if (response.statusCode == 200) {
//           var jsonResponse = jsonDecode(response.body) as List<dynamic>;
//           List<HostedEventDetails> hostedEventDetails =
//               jsonResponse.map((eventData) {
//             return HostedEventDetails(
//                 eventId: eventData['event_id'],
//                 eventName: eventData['event_name'],
//                 eventDate: eventData['event_date'],
//                 eventTime: eventData['event_time'],
//                 eventAddress: eventData['event_address'],
//                 eventDetail: eventData['event_detail'],
//                 eventRsvpBeforeDate: eventData['event_rsvp_before_date'],
//                 eventRsvpBeforeTime: eventData['event_rsvp_before_time'],
//                 eventCode: eventData['event_code']);
//           }).toList();
//           return hostedEventDetails;
//         } else if (response.statusCode == 404) {
//           print('No events found');
//           return [];
//         } else {
//           print('Failed to fetch hosted events');
//           return [];
//         }
//       } catch (error) {
//         print('Error: $error');
//         return [];
//       }
//     }

//     // Call the function to get hosted events' details
//     hostedEventDetails = await getHostedEventDetails();
//   }

//   // void testAdd() {
//   //   final Event event = Event(
//   //     title: 'Study group',
//   //     description: 'Kononnya study la',
//   //     startDate: DateTime(2023, 7, 9, 18, 30),
//   //     endDate: DateTime(2023, 7, 9, 22, 30),
//   //     androidParams: const AndroidParams(
//   //       emailInvites: [
//   //         'farhah@besquare.com.my',
//   //         'asyura@besquare.com.my',
//   //         'lubega@besquare.com.my',
//   //         'haziq@besquare.com.my',
//   //         'munnfaye@besquare.com.my'
//   //       ],
//   //     ),
//   //   );
//   //   Add2Calendar.addEvent2Cal(event);
//   // }

//   // void addToCalendar() async {
//   //   // Request permission first if they haven't been granted
//   //   try {
//   //     var permissionGranted = await _deviceCalendarPlugin.hasPermissions();
//   //     if (permissionGranted.isSuccess && !permissionGranted.data) {
//   //       permissionGranted = await _deviceCalendarPlugin.requestPermissions();
//   //       if (!permissionGranted.isSuccess || !permissionGranted.data) {
//   //         return;
//   //       }
//   //     }
//   //   } catch (error) {
//   //     print('Error: $error');
//   //   }
//   // }

//   void showRSVPPrompt() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       if (_eventCodeController.text.isNotEmpty &&
//           _rsvpStatusController.text.isNotEmpty) {
//         var regBody = {
//           "event_code": _eventCodeController.text,
//           "rsvp_status": _rsvpStatusController.text,
//           "email": email,
//         };

//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('RSVP'),
//               content: const Text('Add RSVP'),
//               actions: [
//                 TextButton(
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     await addRSVP(regBody);
//                   },
//                   child: const Text('Confirm'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }

//   Future<void> addRSVP(Map<String, dynamic> regBody) async {
//     try {
//       var response = await http.post(
//         Uri.parse(addRSVP as String),
//         headers: {
//           "Content-Type": "application/json; charset=utf-8",
//           "Authorization": "Bearer $token"
//         },
//         body: jsonEncode(regBody),
//       );
//       var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
//       var statusCode = jsonResponse['statusCode'] as int?;

//       print(regBody);
//       if (response.statusCode == 200) {
//         _eventCodeController.clear();
//         _rsvpStatusController.clear();
//         print('RSVP added successfully');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('RSVP added successfully'),
//             duration: Duration(seconds: 3),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.green,
//           ),
//         );
//         await Future.delayed(const Duration(seconds: 3));
//         Navigator.pushNamed(context, '/home');
//       } else if (response.statusCode == 500) {
//         print('Failed to add RSVP');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to add RSVP'),
//             duration: Duration(seconds: 3),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.red,
//           ),
//         );
//       } else {
//         print('Something went wrong');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Something went wrong'),
//             duration: Duration(seconds: 3),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.orange,
//           ),
//         );
//         await Future.delayed(const Duration(seconds: 3));
//         Navigator.pushNamed(context, '/error');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }

//   @override
//   void dispose() {
//     print('EventDetailsPage dispose');
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     eventCode = ModalRoute.of(context)?.settings.arguments as String?;

//     if (eventCode != null) {
//       fetchEventDetails(eventCode!);
//     }

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               Navigator.pushNamed(context, '/navigator');
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
//                 PushableButton(
//                   onPressed: () {
//                     print(eventCode);
//                     print("Is it goint to rsvp page for $eventCode");

//                     Navigator.pushNamed(
//                       context,
//                       '/rsvpDetails',
//                       arguments: eventCode,
//                     );
//                     print("pressed to view rsvp");
//                   },
//                   hslColor: HSLColor.fromColor(const Color(0xFFB3AE99)),
//                   shadow: const BoxShadow(
//                     color: Color(0xFF554C3C),
//                   ),
//                   height: 50,
//                   elevation: 8,
//                   child: Text(
//                     'Guest RSVP',
//                     style: TextStyle(
//                       color: Color(0xFFF8F7F2),
//                       fontSize: 24,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: PushableButton(
//                         onPressed: () {
//                           // Handle 'RSVP' button logic
//                           showInvitedEventDetails();
//                         },
//                         hslColor: HSLColor.fromColor(const Color(0xFFB2BBDA)),
//                         shadow: const BoxShadow(
//                           color: Color(0xFF1E3765),
//                         ),
//                         height: 50,
//                         elevation: 8,
//                         child: Text(
//                           'RSVP',
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
//                           // Handle 'Cancel' button logic
//                           // Navigator.pop(context);
//                           showHostedEventDetails();
//                         },
//                         hslColor: HSLColor.fromColor(const Color(0xFFB3AE99)),
//                         shadow: const BoxShadow(
//                           color: Color(0xFF554C3C),
//                         ),
//                         height: 50,
//                         elevation: 8,
//                         child: Text(
//                           'Cancel',
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
//       // bottomNavigationBar: BottomNavPlaceholder(token: token!),
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


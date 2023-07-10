import 'dart:convert';

import 'package:event_management_app/Functions/config.dart';
import 'package:event_management_app/Model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({required this.token, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? token;
  String? email;

  int selectedIndex = 0;

  List<InvitedEvent> invitedEvents = [];
  List<HostedEvent> hostedEvents = [];

  @override
  void initState() {
    print("hi" + "$widget");
    super.initState();
    getTokenFromSharedPrefs();
    showInvitedEvents();
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

  void showInvitedEvents() async {
    Future<List<InvitedEvent>> getInvitedEvents() async {
      try {
        var response = await http.get(
          Uri.parse('$getEventByInviteeEmail$email'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body) as List<dynamic>;
          List<InvitedEvent> invitedEvents = jsonResponse.map((eventData) {
            return InvitedEvent(
                eventId: eventData['event_id'],
                eventName: eventData['event_name'],
                eventDate: eventData['event_date'],
                eventTime: eventData['event_time'],
                eventAddress: eventData['event_address'],
                eventDetail: eventData['event_detail'],
                eventRsvpBeforeDate: eventData['event_rsvp_before_date'],
                eventRsvpBeforeTime: eventData['event_rsvp_before_time'],
                eventCode: eventData['event_code'],
                email: eventData['email'],
                inviteeId: eventData['invitee_id'],
                inviteeEmail: eventData['invitee_email']);
          }).toList();
          return invitedEvents;
        } else if (response.statusCode == 404) {
          print('No events found');
          return [];
        } else {
          print('Failed to fetch invited events');
          return [];
        }
      } catch (error) {
        print('Error: $error');
        return [];
      }
    }

    // Call the function to get invited events
    invitedEvents = await getInvitedEvents();
  }

  void showHostedEvents() async {
    Future<List<HostedEvent>> getHostedEvents() async {
      try {
        var response = await http.get(
          Uri.parse('$getEventByEmail$email'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body) as List<dynamic>;
          List<HostedEvent> hostedEvents = jsonResponse.map((eventData) {
            return HostedEvent(
                eventId: eventData['event_id'],
                eventName: eventData['event_name'],
                eventDate: eventData['event_date'],
                eventTime: eventData['event_time'],
                eventAddress: eventData['event_address'],
                eventDetail: eventData['event_detail'],
                eventRsvpBeforeDate: eventData['event_rsvp_before_date'],
                eventRsvpBeforeTime: eventData['event_rsvp_before_time'],
                eventCode: eventData['event_code'],
                email: eventData['email']);
          }).toList();
          return hostedEvents;
        } else if (response.statusCode == 404) {
          print('No events found');
          return [];
        } else {
          print('Failed to fetch hosted events');
          return [];
        }
      } catch (error) {
        print('Error: $error');
        return [];
      }
    }

    // Call the function to get invited events
    hostedEvents = await getHostedEvents();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Text(
                  "Events",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF6B5F4A),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleSwitch(
                      minWidth: 120.0,
                      minHeight: 50.0,
                      initialLabelIndex: selectedIndex,
                      activeBgColor: const [Color(0xFF2A4F92)],
                      inactiveBgColor: const Color(0xFFC3C3C4),
                      activeFgColor: Colors.white,
                      inactiveFgColor: Colors.grey[900],
                      labels: const ['Invited', 'Hosted'],
                      customTextStyles: [
                        TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ],
                      onToggle: (index) {
                        setState(() {
                          selectedIndex = index!;
                          // To show 'invited to' events
                          if (index == 0) {
                            showInvitedEvents();
                          } else if (index == 1) {
                            // To show created/hosted events
                            showHostedEvents();
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final double containerWidth = constraints.maxWidth < 360
                            ? constraints.maxWidth
                            : 360;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/eventDetails');
                                },
                                child: _buildEventContainer(containerWidth),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventContainer(double containerWidth) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB3AE99),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedIndex == 0) ...{
            _buildEventCard(containerWidth, invitedEvents, true),
          } else if (selectedIndex == 1) ...{
            _buildEventCard(containerWidth, hostedEvents, false),
          },
        ],
      ),
    );
  }

  Widget _buildEventCard(
      double containerWidth, List<dynamic> events, bool isInvitedEvent,
      {EdgeInsetsGeometry? margin}) {
    return Container(
      height: 130,
      width: containerWidth,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          dynamic event = events[index];

          if (isInvitedEvent) {
            InvitedEvent invitedEvent = event as InvitedEvent;
            return ListTile(
              title: Text(invitedEvent.eventName),
              subtitle: Text(invitedEvent.eventDate),
            );
          } else {
            HostedEvent hostedEvent = event as HostedEvent;
            return ListTile(
              title: Text(hostedEvent.eventName),
              subtitle: Text(hostedEvent.eventDate),
            );
          }
        },
      ),
    );
  }
}

//   Widget _buildEventContainer(double containerWidth) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFB3AE99),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildEventCard(containerWidth),
//           _buildEventCard(containerWidth,
//               margin: const EdgeInsets.only(top: 11)),
//           _buildEventCard(containerWidth,
//               margin: const EdgeInsets.only(top: 12)),
//           _buildEventCard(containerWidth,
//               margin: const EdgeInsets.only(top: 13, bottom: 2)),
//         ],
//       ),
//     );
//   }

//   Widget _buildEventCard(double containerWidth, {EdgeInsetsGeometry? margin}) {
//     return Container(
//       height: 130,
//       width: containerWidth,
//       margin: margin,
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 255, 255, 255),
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }
// }

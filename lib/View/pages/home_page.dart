import 'dart:convert';

import 'package:event_management_app/Functions/config.dart';
import 'package:event_management_app/Model/event_model.dart';
import 'package:event_management_app/View/pages/event_details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Event {
  final String eventId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventAddress;
  final String eventCode;

  Event({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventAddress,
    required this.eventCode,
  });
}

class InvitedEvent extends Event {
  InvitedEvent({
    required String eventId,
    required String eventName,
    required String eventDate,
    required String eventTime,
    required String eventAddress,
    required String eventCode,
  }) : super(
          eventId: eventId,
          eventName: eventName,
          eventDate: eventDate,
          eventTime: eventTime,
          eventAddress: eventAddress,
          eventCode: eventCode,
        );
}

class HostedEvent extends Event {
  HostedEvent({
    required String eventId,
    required String eventName,
    required String eventDate,
    required String eventTime,
    required String eventAddress,
    required String eventCode,
  }) : super(
          eventId: eventId,
          eventName: eventName,
          eventDate: eventDate,
          eventTime: eventTime,
          eventAddress: eventAddress,
          eventCode: eventCode,
        );
}

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
                eventCode: eventData['event_code']);
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
                eventCode: eventData['event_code']);
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
    return Scaffold(
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
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis
                                .vertical, // Set the scroll direction to vertical
                            itemCount: 10, // Total number of items in the list
                            itemBuilder: (context, index) {
                              final double containerWidth =
                                  MediaQuery.of(context).size.width < 360
                                      ? MediaQuery.of(context).size.width
                                      : 360;
                              Event event;
                              String eventType;
                              if (selectedIndex == 0 &&
                                  invitedEvents.length > index) {
                                event = invitedEvents[index];
                                eventType = 'invited';
                              } else if (selectedIndex == 1 &&
                                  hostedEvents.length > index) {
                                event = hostedEvents[index];
                                eventType = 'host';
                              } else {
                                return SizedBox();
                              }
                              return GestureDetector(
                                onTap: () {
                                  print(selectedIndex);
                                  print(event.eventCode);
                                  print("Is it working for $eventType");

                                  Navigator.pushNamed(
                                    context,
                                    '/eventDetails',
                                    arguments: event.eventCode,
                                  );
                                },
                                child:
                                    _buildEventContainer(containerWidth, event),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventContainer(double containerWidth, Event event) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB3AE99),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (event is InvitedEvent) ...{
            _buildInvitedEventCard(containerWidth, event),
          } else if (event is HostedEvent) ...{
            _buildHostedEventCard(containerWidth, event),
          },
        ],
      ),
    );
  }

  // Widget _buildEventCard(
  //     double containerWidth, List<dynamic> events, bool isInvitedEvent,
  //     {EdgeInsetsGeometry? margin}) {
  //   return Container(
  //     height: 130,
  //     width: containerWidth,
  //     margin: margin,
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(255, 255, 255, 255),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: ListView.builder(
  //       itemCount: events.length,
  //       itemBuilder: (context, index) {
  //         dynamic event = events[index];

  //         if (isInvitedEvent) {
  //           InvitedEvent invitedEvent = event as InvitedEvent;
  //           return ListTile(
  //             title: Text('${events[index].eventName}'),
  //             subtitle: Text('${events[index].eventDate}'),
  //           );
  //         } else {
  //           HostedEvent hostedEvent = event as HostedEvent;
  //           return ListTile(
  //             title: Text('${events[index].eventName}'),
  //             subtitle: Text('${events[index].eventDate}'),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  //Testing custom widget
  Widget _buildInvitedEventCard(double containerWidth, InvitedEvent event) {
    String trimmedEventDate = event.eventDate.substring(0, 10);
    return Container(
      height: 130,
      width: containerWidth,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomListItem(
        eventName: event.eventName,
        eventAddress: event.eventAddress,
        eventDate: trimmedEventDate,
        eventTime: event.eventTime,
      ),
    );
  }

  // //Functioning widget
  // Widget _buildInvitedEventCard(double containerWidth, int index) {
  //   InvitedEvent invitedEvent = invitedEvents[index];
  //   String trimmedEventDate = invitedEvent.eventDate.substring(0, 10);
  //   return Container(
  //     height: 130,
  //     width: containerWidth,
  //     margin: const EdgeInsets.all(8),
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(255, 255, 255, 255),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: ListTile(
  //       title: Text(invitedEvent.eventName),
  //       subtitle: Text(trimmedEventDate),
  //     ),
  //   );
  // }

  Widget _buildHostedEventCard(double containerWidth, HostedEvent event) {
    String trimmedEventDate = event.eventDate.substring(0, 10);
    return Container(
      height: 130,
      width: containerWidth,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(event.eventName),
        subtitle: Text(trimmedEventDate),
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
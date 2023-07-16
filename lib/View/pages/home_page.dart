import 'dart:convert';

import 'package:event_management_app/Functions/config.dart';
import 'package:event_management_app/Model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:google_fonts/google_fonts.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({required this.token, Key? key}) : super(key: key);

//   final String token;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String? email;
//   List<HostedEvent> hostedEvents = [];
//   List<InvitedEvent> invitedEvents = [];
//   int selectedIndex = 0;
//   String? token;

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   void initState() {
//     print("hi" + "$widget");
//     super.initState();
//     getTokenFromSharedPrefs();
//     showInvitedEvents();
//     showHostedEvents();
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
//         print(email);
//       }
//     }
//   }

//   void showInvitedEvents() async {
//     Future<List<InvitedEvent>> getInvitedEvents() async {
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
//           List<InvitedEvent> invitedEvents = jsonResponse.map((eventData) {
//             return InvitedEvent(
//                 eventName: eventData['event_name'],
//                 eventDate: eventData['event_date'],
//                 eventTime: eventData['event_time'],
//                 eventAddress: eventData['event_address'],
//                 eventCode: eventData['event_code']);
//           }).toList();
//           return invitedEvents;
//         } else if (response.statusCode == 404) {
//           print('No events found');
//           return [];
//         } else {
//           print('Failed to fetch invited events');
//           return [];
//         }
//       } catch (error) {
//         print('Error: $error');
//         return [];
//       }
//     }

//     // Call the function to get invited events
//     invitedEvents = await getInvitedEvents();
//   }

//   void showHostedEvents() async {
//     Future<List<HostedEvent>> getHostedEvents() async {
//       try {
//         var response = await http.get(
//           Uri.parse('$getEventByEmail$email'),
//           headers: {
//             "Content-Type": "application/json",
//             "Authorization": "Bearer $token"
//           },
//         );

//         print('Response status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         if (response.statusCode == 200) {
//           var jsonResponse = jsonDecode(response.body) as List<dynamic>;
//           List<HostedEvent> hostedEvents = jsonResponse.map((eventData) {
//             return HostedEvent(
//                 eventName: eventData['event_name'],
//                 eventDate: eventData['event_date'],
//                 eventTime: eventData['event_time'],
//                 eventAddress: eventData['event_address'],
//                 eventCode: eventData['event_code']);
//           }).toList();
//           return hostedEvents;
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

//     // Call the function to get hosted events
//     hostedEvents = await getHostedEvents();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: const Color(0xFFFFFCF9),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 22.0, left: 25.0),
//                     child: Text(
//                       "Events",
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                       style: GoogleFonts.poppins(
//                         fontSize: 28.0,
//                         fontWeight: FontWeight.w800,
//                         color: const Color(0xFF6B5F4A),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20.0),
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ToggleSwitch(
//                       minWidth: 120.0,
//                       minHeight: 50.0,
//                       initialLabelIndex: selectedIndex,
//                       activeBgColor: const [Color(0xFF2A4F92)],
//                       inactiveBgColor: const Color(0xFFC3C3C4),
//                       activeFgColor: Colors.white,
//                       inactiveFgColor: Colors.grey[900],
//                       labels: const ['Invited', 'Hosted'],
//                       customTextStyles: [
//                         TextStyle(
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: GoogleFonts.poppins().fontFamily,
//                         ),
//                       ],
//                       onToggle: (index) {
//                         setState(() {
//                           selectedIndex = index!;
//                           // To show 'invited to' events
//                           if (index == 0) {
//                             showInvitedEvents();
//                           } else if (index == 1) {
//                             // To show created/hosted events
//                             showHostedEvents();
//                           }
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               scrollDirection: Axis.vertical,
//                               itemCount: 10,
//                               itemBuilder: (context, index) {
//                                 final double containerWidth =
//                                     MediaQuery.of(context).size.width < 360
//                                         ? MediaQuery.of(context).size.width
//                                         : 360;
//                                 Event event;
//                                 String eventType;
//                                 if (selectedIndex == 0 &&
//                                     invitedEvents.length > index) {
//                                   event = invitedEvents[index];
//                                   eventType = 'invited';
//                                 } else if (selectedIndex == 1 &&
//                                     hostedEvents.length > index) {
//                                   event = hostedEvents[index];
//                                   eventType = 'host';
//                                 } else {
//                                   return SizedBox();
//                                 }
//                                 return GestureDetector(
//                                   onTap: () {
//                                     print(selectedIndex);
//                                     print(event.eventCode);
//                                     print("Is it working for $eventType");
//                                     Navigator.pushNamed(
//                                       context,
//                                       '/test',
//                                       arguments: event.eventCode,
//                                     );
//                                   },
//                                   child: _buildEventContainer(
//                                       containerWidth, event),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEventContainer(double containerWidth, Event event) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5.0, right: 5.0),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Color(0xFFB3AE99),
//           shape: BoxShape.rectangle,
//         ),
//         padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (event is InvitedEvent) ...{
//               _buildInvitedEventCard(containerWidth, event),
//             } else if (event is HostedEvent) ...{
//               _buildHostedEventCard(containerWidth, event),
//             },
//           ],
//         ),
//       ),
//     );
//   }

//   // Custom widget for invited events
//   Widget _buildInvitedEventCard(double containerWidth, InvitedEvent event) {
//     return Container(
//       height: 130,
//       width: containerWidth,
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 255, 255, 255),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: CustomListItem(
//         eventName: event.eventName,
//         eventAddress: event.eventAddress,
//         eventDate: DateFormat.yMMMd().format(DateTime.parse(event.eventDate)),
//         eventTime: event.eventTime,
//       ),
//     );
//   }

//   // Custom widget for hosted event
//   Widget _buildHostedEventCard(double containerWidth, HostedEvent event) {
//     return Container(
//       height: 130,
//       width: containerWidth,
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 255, 255, 255),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: CustomListItem(
//         eventName: event.eventName,
//         eventAddress: event.eventAddress,
//         eventDate: DateFormat.yMMMd().format(DateTime.parse(event.eventDate)),
//         eventTime: event.eventTime,
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({required this.token, Key? key}) : super(key: key);

  final String token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email;
  List<HostedEvent> hostedEvents = [];
  List<InvitedEvent> invitedEvents = [];
  int selectedIndex = 0;
  String? token;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getTokenFromSharedPrefs();
    showInvitedEvents();
    showHostedEvents();
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
    setState(() {
      _isLoading = true;
    });

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
        invitedEvents = jsonResponse.map((eventData) {
          return InvitedEvent(
              eventName: eventData['event_name'],
              eventDate: eventData['event_date'],
              eventTime: eventData['event_time'],
              eventAddress: eventData['event_address'],
              eventCode: eventData['event_code']);
        }).toList();
      } else if (response.statusCode == 404) {
        print('No events found');
        invitedEvents = [];
      } else {
        print('Failed to fetch invited events');
        invitedEvents = [];
      }
    } catch (error) {
      print('Error: $error');
      invitedEvents = [];
    }

    setState(() {
      _isLoading = false;
    });
  }

  void showHostedEvents() async {
    setState(() {
      _isLoading = true;
    });

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
        hostedEvents = jsonResponse.map((eventData) {
          return HostedEvent(
              eventName: eventData['event_name'],
              eventDate: eventData['event_date'],
              eventTime: eventData['event_time'],
              eventAddress: eventData['event_address'],
              eventCode: eventData['event_code']);
        }).toList();
      } else if (response.statusCode == 404) {
        print('No events found');
        hostedEvents = [];
      } else {
        print('Failed to fetch hosted events');
        hostedEvents = [];
      }
    } catch (error) {
      print('Error: $error');
      hostedEvents = [];
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFFFCF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0, left: 25.0),
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
                ],
              ),
              const SizedBox(height: 20.0),
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
                    EventList(
                      isLoading: _isLoading,
                      selectedIndex: selectedIndex,
                      invitedEvents: invitedEvents,
                      hostedEvents: hostedEvents,
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
}

class EventList extends StatelessWidget {
  const EventList({
    Key? key,
    required this.isLoading,
    required this.selectedIndex,
    required this.invitedEvents,
    required this.hostedEvents,
  }) : super(key: key);

  final bool isLoading;
  final int selectedIndex;
  final List<InvitedEvent> invitedEvents;
  final List<HostedEvent> hostedEvents;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: const Color(0xFF1E3765),
        ),
      );
    } else {
      return SizedBox(
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: selectedIndex == 0
                    ? invitedEvents.length
                    : hostedEvents.length,
                itemBuilder: (context, index) {
                  final double containerWidth =
                      MediaQuery.of(context).size.width < 360
                          ? MediaQuery.of(context).size.width
                          : 360;
                  Event event;
                  String eventType;
                  if (selectedIndex == 0 && invitedEvents.length > index) {
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
                        '/test',
                        arguments: event.eventCode,
                      );
                    },
                    child: _buildEventContainer(containerWidth, event),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildEventContainer(double containerWidth, Event event) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFB3AE99),
          shape: BoxShape.rectangle,
        ),
        padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
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
      ),
    );
  }

  // Custom widget for invited events
  Widget _buildInvitedEventCard(double containerWidth, InvitedEvent event) {
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
        eventDate: DateFormat.yMMMd().format(DateTime.parse(event.eventDate)),
        eventTime: event.eventTime,
      ),
    );
  }

  // Custom widget for hosted event
  Widget _buildHostedEventCard(double containerWidth, HostedEvent event) {
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
        eventDate: DateFormat.yMMMd().format(DateTime.parse(event.eventDate)),
        eventTime: event.eventTime,
      ),
    );
  }
}

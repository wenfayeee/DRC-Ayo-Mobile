// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:event_management_app/Functions/config.dart';
import 'package:event_management_app/Model/event_model.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:google_fonts/google_fonts.dart';

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
  }

  void getTokenFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null) {
      setState(() {
        token = storedToken;
      });
      decodeToken();
      showInvitedEvents();
      showHostedEvents();
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
        return Dialogs.materialDialog(
          context: context,
          title: 'No events found.',
          lottieBuilder:
              Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: 'Please try again.',
          msgAlign: TextAlign.center,
          msgStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000),
          ),
          color: const Color(0xFFF8F7F2),
          titleStyle: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF000000),
          ),
          actions: [
            PushableButton(
              onPressed: () {
                Navigator.pop(context);
              },
              hslColor: HSLColor.fromColor(const Color(0xFF888789)),
              shadow: const BoxShadow(
                color: Color(0xFF505457),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Try Again',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8F7F2),
                ),
              ),
            ),
          ],
        );
      } else {
        return Dialogs.materialDialog(
          context: context,
          title: 'Failed to fetch invited events.',
          lottieBuilder:
              Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: 'Please try again.',
          msgAlign: TextAlign.center,
          msgStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000),
          ),
          color: const Color(0xFFF8F7F2),
          titleStyle: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF000000),
          ),
          actions: [
            PushableButton(
              onPressed: () {
                Navigator.pop(context);
              },
              hslColor: HSLColor.fromColor(const Color(0xFF888789)),
              shadow: const BoxShadow(
                color: Color(0xFF505457),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Try Again',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8F7F2),
                ),
              ),
            ),
          ],
        );
      }
    } catch (error) {
      return Dialogs.materialDialog(
        context: context,
        title: 'Something went wrong.',
        lottieBuilder:
            Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
        titleAlign: TextAlign.center,
        msg: 'Please try again later.',
        msgAlign: TextAlign.center,
        msgStyle: GoogleFonts.poppins(
          fontSize: 16.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF000000),
        ),
        color: const Color(0xFFF8F7F2),
        titleStyle: GoogleFonts.poppins(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF000000),
        ),
        actions: [
          PushableButton(
            onPressed: () {
              Navigator.pop(context);
            },
            hslColor: HSLColor.fromColor(const Color(0xFF888789)),
            shadow: const BoxShadow(
              color: Color(0xFF505457),
            ),
            height: 50,
            elevation: 8,
            child: Text(
              'Ok',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF8F7F2),
              ),
            ),
          ),
        ],
      );
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
        return Dialogs.materialDialog(
          context: context,
          title: 'No events found.',
          lottieBuilder:
              Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: 'Please try again.',
          msgAlign: TextAlign.center,
          msgStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000),
          ),
          color: const Color(0xFFF8F7F2),
          titleStyle: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF000000),
          ),
          actions: [
            PushableButton(
              onPressed: () {
                Navigator.pop(context);
              },
              hslColor: HSLColor.fromColor(const Color(0xFF888789)),
              shadow: const BoxShadow(
                color: Color(0xFF505457),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Try Again',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8F7F2),
                ),
              ),
            ),
          ],
        );
      } else {
        return Dialogs.materialDialog(
          context: context,
          title: 'Failed to fetch hosted events.',
          lottieBuilder:
              Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: 'Please try again.',
          msgAlign: TextAlign.center,
          msgStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000),
          ),
          color: const Color(0xFFF8F7F2),
          titleStyle: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF000000),
          ),
          actions: [
            PushableButton(
              onPressed: () {
                Navigator.pop(context);
              },
              hslColor: HSLColor.fromColor(const Color(0xFF888789)),
              shadow: const BoxShadow(
                color: Color(0xFF505457),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Try Again',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8F7F2),
                ),
              ),
            ),
          ],
        );
      }
    } catch (error) {
      return Dialogs.materialDialog(
        context: context,
        title: 'Something went wrong.',
        lottieBuilder:
            Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
        titleAlign: TextAlign.center,
        msg: 'Please try again later.',
        msgAlign: TextAlign.center,
        msgStyle: GoogleFonts.poppins(
          fontSize: 16.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF000000),
        ),
        color: const Color(0xFFF8F7F2),
        titleStyle: GoogleFonts.poppins(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF000000),
        ),
        actions: [
          PushableButton(
            onPressed: () {
              Navigator.pop(context);
            },
            hslColor: HSLColor.fromColor(const Color(0xFF888789)),
            shadow: const BoxShadow(
              color: Color(0xFF505457),
            ),
            height: 50,
            elevation: 8,
            child: Text(
              'Ok',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF8F7F2),
              ),
            ),
          ),
        ],
      );
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
                      customTextStyles: const [
                        TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
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
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1E3765),
        ),
      );
    } else {
      Widget emptyEventsContainer = SizedBox.fromSize();
      Widget emptyHostedEventsContainer = SizedBox.fromSize();

      bool isInvitedEventsEmpty = selectedIndex == 0 && invitedEvents.isEmpty;
      bool isHostedEventsEmpty = selectedIndex == 1 && hostedEvents.isEmpty;

      if (isInvitedEventsEmpty) {
        emptyEventsContainer = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFFC3C3C3),
          ),
          height: 100.0,
          width: 350.0,
          child: const Center(
            child: Text(
              'You have no invited events yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Color(0xFF505457),
              ),
            ),
          ),
        );
      }

      if (isHostedEventsEmpty) {
        emptyHostedEventsContainer = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFFC3C3C3),
          ),
          height: 100.0,
          width: 350.0,
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF505457),
                ),
                children: [
                  TextSpan(
                    text: 'You have not hosted any events.',
                  ),
                  TextSpan(text: '\nClick the '),
                  WidgetSpan(
                    child:
                        Icon(IconsaxBold.add_square, color: Color(0xFFF8F7F2)),
                  ),
                  TextSpan(
                    text: ' icon to create an event.',
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            emptyEventsContainer,
            emptyHostedEventsContainer,
            if (!isInvitedEventsEmpty && !isHostedEventsEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: selectedIndex == 0
                    ? invitedEvents.length
                    : hostedEvents.length,
                itemBuilder: (context, index) {
                  final double containerWidth =
                      MediaQuery.of(context).size.width < 500
                          ? MediaQuery.of(context).size.width
                          : 500;
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
                    return const SizedBox();
                  }
                  return GestureDetector(
                    onTap: () {
                      if (eventType == 'invited') {
                        Navigator.pushNamed(context, '/eventDetailsInvited',
                            arguments: event.eventCode);
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/eventDetailsHosted',
                          arguments: event.eventCode,
                        );
                      }
                    },
                    child: _buildEventContainer(containerWidth, event),
                  );
                },
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
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (event is InvitedEvent)
              _buildInvitedEventCard(containerWidth, event),
            if (event is HostedEvent)
              _buildHostedEventCard(containerWidth, event),
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
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomListItem(
            eventName: event.eventName,
            eventAddress: event.eventAddress,
            eventDate:
                DateFormat.yMMMd().format(DateTime.parse(event.eventDate)),
            eventTime: event.eventTime,
          ),
        ],
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
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomListItem(
            eventName: event.eventName,
            eventAddress: event.eventAddress,
            eventDate:
                DateFormat.yMMMd().format(DateTime.parse(event.eventDate)),
            eventTime: event.eventTime,
          ),
        ],
      ),
    );
  }
}

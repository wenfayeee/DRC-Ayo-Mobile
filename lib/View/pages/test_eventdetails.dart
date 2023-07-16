import 'dart:convert';

import 'package:device_calendar/device_calendar.dart' as device_calendar;
import 'package:event_management_app/Functions/config.dart';
import 'package:event_management_app/Model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:permission_handler/permission_handler.dart';

class TestPage extends StatefulWidget {
  final String token;
  final String eventCode;
  const TestPage({required this.token, required this.eventCode, Key? key})
      : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String? token;
  String? email;
  String? eventCode;
  String? rsvpStatus;

  final _eventCodeController = TextEditingController();

  bool isEventDetailsFetched = false;
  bool isEventCodeProcessing = false;

  List<SpecificEventDetails> specificEventDetails = [];

  @override
  void initState() {
    super.initState();
    print("hi" + "$widget");
    getTokenFromSharedPrefs();
  }

  // Access the event code from widget object
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchEventDetails(widget.eventCode);
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

  @override
  void dispose() {
    super.dispose();
    _eventCodeController.dispose();
  }

  // Show specific event details
  Future<List<SpecificEventDetails>> getEventDetails() async {
    print("this pass");
    try {
      var response = await http.get(
        Uri.parse('$getEventByEventCode$eventCode'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      print("pass ro fail");
      print(eventCode);
      print(token);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        List<SpecificEventDetails> specificEventDetails =
            jsonResponse.map((eventData) {
          return SpecificEventDetails(
              eventName: eventData['event_name'],
              eventDate: eventData['event_date'],
              eventTime: eventData['event_time'],
              eventAddress: eventData['event_address'],
              eventDetail: eventData['event_detail'],
              eventRSVPBeforeDate: eventData['event_rsvp_before_date'],
              eventRSVPBeforeTime: eventData['event_rsvp_before_time'],
              eventCode: eventData['event_code']);
        }).toList();
        return specificEventDetails;
      } else if (response.statusCode == 500) {
        print('No event details found');
        return [];
      } else {
        print('Failed to fetch the event details');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  void fetchEventDetails(String eventCode) async {
    if (!isEventDetailsFetched) {
      List<SpecificEventDetails> details = await getEventDetails();
      setState(() {
        specificEventDetails = details;
        isEventDetailsFetched = true;
      });
    }
  }

  // Dialog for RSVP prompt
  Future<void> _showRSVPPrompt(Function(String) responseCallback) async {
    return Dialogs.materialDialog(
      context: context,
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      title: 'Would you like to attend this event?',
      titleAlign: TextAlign.center,
      color: const Color(0xFFF8F7F2),
      titleStyle: GoogleFonts.poppins(
        fontSize: 18.0,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF505457),
      ),
      actions: [
        Container(
          child: PushableButton(
            onPressed: () {
              // Handle 'RSVP' button logic
              print('RSVP yes');
              responseCallback('Yes');
              _showEventCodePrompt(widget.eventCode, responseCallback);
              Navigator.pop(context);
            },
            hslColor: HSLColor.fromColor(const Color(0xFFB2BBDA)),
            shadow: const BoxShadow(
              color: Color(0xFF1E3765),
            ),
            height: 50,
            elevation: 8,
            child: Text(
              'Yes',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E3765),
              ),
            ),
          ),
        ),
        Container(
          child: PushableButton(
            onPressed: () {
              // Handle 'Cancel' button logic
              print('RSVP no');
              // sendRSVPStatus(eventCode!, 'No');
              responseCallback('No');
              Navigator.pop(context);
            },
            hslColor: HSLColor.fromColor(const Color(0xFFDCA1A1)),
            shadow: const BoxShadow(
              color: Color(0xFFAC1010),
            ),
            height: 50,
            elevation: 8,
            child: Text(
              'No',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFAC1010),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Dialog for event_code prompt
  Future<void> _showEventCodePrompt(
      String eventCode, Function(String) responseCallback) async {
    return Dialogs.materialDialog(
      context: context,
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      title: 'Enter the event code to confirm your RSVP',
      titleAlign: TextAlign.center,
      color: const Color(0xFFF8F7F2),
      titleStyle: GoogleFonts.poppins(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        color: const Color(0xFF505457),
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _eventCodeController,
              keyboardType: TextInputType.text,
              style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000000)),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                hintText: 'Event Code',
                contentPadding: EdgeInsets.all(12.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFC3C3C3),
                ),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 30.0),
            PushableButton(
              onPressed: () async {
                setState(() {
                  isEventCodeProcessing = true;
                });
                print('Event code here');
                // Parse the body
                Map<String, dynamic> requestBody = {
                  "event_code": _eventCodeController.text,
                  "rsvp_status": 'Yes',
                };

                responseCallback('Yes');
                // await Future.delayed(const Duration(milliseconds: 300));

                if (isEventCodeProcessing) {
                  setState(() {
                    isEventCodeProcessing = false;
                  });
                }
              },
              hslColor: HSLColor.fromColor(
                const Color(0xFF1E3765),
              ),
              shadow: const BoxShadow(
                color: Color(0xFF1E3765),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Confirm',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8F7F2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void sendRSVPStatus(String eventCode, String rsvp) async {
    rsvpStatus = rsvp;
    try {
      var response = await http.post(
        Uri.parse(addRSVP),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "event_code": eventCode,
          "rsvp_status": rsvp,
        }),
      );

      print(eventCode);
      print(rsvp);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        print('RSVP sent successfully');
        // Handle success scenario
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('RSVP added successfully'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Failed to send RSVP');
        // Handle failure scenario
      }
    } catch (error) {
      print('Error: $error');
      // Handle error scenario with error page
    }
  }

  // Future<void> addEventToCalendar(Event event) async {
  //   // Check if permission is granted to access the device's calendar
  //   PermissionStatus permissionStatus = await Permission.calendar.status;

  //   // Check if permission is granted or already granted in previous request
  //   if (permissionStatus.isGranted || permissionStatus.isLimited) {
  //     // Retrieve the default calendar on the device
  //     device_calendar.DeviceCalendarPlugin deviceCalendarPlugin =
  //         device_calendar.DeviceCalendarPlugin();
  //     device_calendar.Result<List<device_calendar.Calendar>> calendarsResult =
  //         await deviceCalendarPlugin.retrieveCalendars();
  //     List<device_calendar.Calendar>? calendars = calendarsResult.data;

  //     if (calendars != null && calendars.isNotEmpty) {
  //       device_calendar.Calendar defaultCalendar = calendars.first;

  //       // Format event date and time
  //       String formattedDate = DateFormat('yyyy-MM-dd').format(event.eventDate);
  //       String formattedTime =
  //           DateFormat('HH:mm').format(DateTime.parse(event.eventTime));

  //       // Create the event object
  //       device_calendar.Event calendarEvent =
  //           device_calendar.Event(defaultCalendar.id);
  //       calendarEvent.title = event.eventName;
  //       calendarEvent.start =
  //           DateTime.parse('$formattedDate $formattedTime').toUtc();
  //       calendarEvent.end = calendarEvent.start.add(Duration(hours: 1));
  //       calendarEvent.location = event.eventAddress;

  //       // Save the event to the default calendar
  //       device_calendar.Result<String> createdEventResult =
  //           await deviceCalendarPlugin.createOrUpdateEvent(calendarEvent);

  //       if (createdEventResult.isSuccess) {
  //         print('Event added to calendar successfully');
  //       } else {
  //         print('Failed to add event to calendar');
  //       }
  //     } else {
  //       print('No calendars found on the device');
  //     }
  //   } else {
  //     // Request calendar permission
  //     permissionStatus = await Permission.calendar.request();

  //     if (permissionStatus.isGranted || permissionStatus.isLimited) {
  //       // Call the addEventToCalendar function again to add the event after permission is granted
  //       addEventToCalendar(event);
  //     } else {
  //       print('Calendar permission not granted');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    eventCode = ModalRoute.of(context)?.settings.arguments as String?;

    if (eventCode != null) {
      fetchEventDetails(eventCode!);
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/navigator');
            },
            icon: const Icon(Icons.cancel_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 120.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            Text(
              'Event Details',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 28.0,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF6B5F4A),
              ),
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: specificEventDetails.isNotEmpty
                  ? BuildEventCard(
                      specificEventDetails: specificEventDetails,
                    )
                  : Container(),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PushableButton(
                    onPressed: () {
                      // Handle 'RSVP' button logic
                      print('To proceed with RSVP');
                      _showRSVPPrompt((response) {
                        if (response == 'Yes') {
                          _showEventCodePrompt(eventCode!, (eventCodeResponse) {
                            sendRSVPStatus(eventCode!, eventCodeResponse);
                          });
                        } else if (response == 'No') {
                          sendRSVPStatus(eventCode!, response);
                        }
                      });
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
      ),
    );
  }
}

class BuildEventCard extends StatelessWidget {
  const BuildEventCard({Key? key, required this.specificEventDetails})
      : super(key: key);

  final List<SpecificEventDetails> specificEventDetails;

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
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView.builder(
                itemCount: specificEventDetails.length,
                itemBuilder: (context, index) {
                  return CustomEventsListItem(
                    eventName: specificEventDetails[index].eventName,
                    eventAddress: specificEventDetails[index].eventAddress,
                    eventDate: DateFormat.yMMMd().format(
                        DateTime.parse(specificEventDetails[index].eventDate)),
                    eventTime: specificEventDetails[index].eventTime,
                    eventDetail: specificEventDetails[index].eventDetail,
                    eventRSVPBeforeDate: DateFormat.yMMMd().format(
                        DateTime.parse(
                            specificEventDetails[index].eventRSVPBeforeDate)),
                    eventRSVPBeforeTime:
                        specificEventDetails[index].eventRSVPBeforeTime,
                    eventCode: specificEventDetails[index].eventCode,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

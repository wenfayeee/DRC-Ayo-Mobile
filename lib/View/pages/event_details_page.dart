// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:event_management_app/Functions/config.dart';
import 'package:event_management_app/Model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetailsPage extends StatefulWidget {
  final String token;
  final String eventCode;
  final bool isHost;
  final bool isInvited;
  const EventDetailsPage(
      {required this.token,
      required this.eventCode,
      required this.isHost,
      required this.isInvited,
      Key? key})
      : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
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

  void fetchEventDetails(String eventCode) async {
    setState(() {});
    if (!isEventDetailsFetched) {
      List<SpecificEventDetails> details = await getEventDetails(eventCode);
      setState(() {
        specificEventDetails = details;
        isEventDetailsFetched = true;
      });
    }
  }

  void showError1() async {
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

  void showError2() async {
    return Dialogs.materialDialog(
      context: context,
      title: 'No event details found.',
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

  // Show specific event details
  Future<List<SpecificEventDetails>> getEventDetails(String eventCode) async {
    try {
      var response = await http.get(
        Uri.parse('$getEventByEventCode$eventCode'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
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
        showError2();
        return [];
      }
    } catch (error) {
      showError1();
      return [];
    }
    return specificEventDetails;
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
              // Handle 'No' button logic
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
        Container(
          child: PushableButton(
            onPressed: () {
              // Handle 'Yes' button logic
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
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an event code.';
                }
                if (value.length > 21) {
                  return 'Event code can only be maximum 20 characters.';
                }
                if (value.contains(
                    RegExp(r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                  return 'Invalid input';
                }
                return null;
              },
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
                Map<String, dynamic> requestBody = {
                  "event_code": _eventCodeController.text,
                  "rsvp_status": 'Yes',
                };
                responseCallback('Yes');
                _eventCodeController.clear();
                Navigator.pushNamed(context, '/navigator');
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
      if (response.statusCode == 200) {
        // Handle success scenario
        return Dialogs.materialDialog(
          context: context,
          title: 'Success!',
          lottieBuilder: Lottie.asset('assets/animations/success.json',
              fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: "Great! You have successfully RSVP 'Yes' for the event",
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
                Navigator.pushNamed(context, '/navigator');
              },
              hslColor: HSLColor.fromColor(const Color(0xFF888789)),
              shadow: const BoxShadow(
                color: Color(0xFF505457),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Continue',
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
        // Handle failure scenario
        return Dialogs.materialDialog(
          context: context,
          title: 'Failed to send RSVP',
          lottieBuilder:
              Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: 'Oh no! You entered an invalid event code. \nPlease try again',
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
  }

  Future<void> _showDeletePrompt(String eventCode) async {
    return Dialogs.materialDialog(
      context: context,
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      title: 'Are you sure you want to delete this event?',
      titleAlign: TextAlign.center,
      color: const Color(0xFFB2BBDA),
      titleStyle: GoogleFonts.poppins(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF505457),
      ),
      actions: [
        Container(
          child: PushableButton(
            onPressed: () {
              // Handle 'Cancel' button logic
              Navigator.pop(context);
            },
            hslColor: HSLColor.fromColor(const Color(0xFFF8F9FC)),
            shadow: const BoxShadow(
              color: Color(0xFFF8F9FC),
            ),
            height: 50,
            elevation: 8,
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF888789),
              ),
            ),
          ),
        ),
        Container(
          child: PushableButton(
            onPressed: () {
              // Handle 'Confirm' button logic
              removeEvent(eventCode);
              Navigator.pushNamed(context, '/navigator');
            },
            hslColor: HSLColor.fromColor(const Color(0xFF2A4F92)),
            shadow: const BoxShadow(
              color: Color(0xFF2A4F92),
            ),
            height: 50,
            elevation: 8,
            child: Text(
              'Confirm',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF8F9FC),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> removeEvent(String eventCode) async {
    try {
      final response = await http.delete(
        Uri.parse('$deleteEvent$eventCode'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({'eventCode': eventCode}),
      );
      if (response.statusCode == 200) {
        return Dialogs.materialDialog(
          context: context,
          title: 'Success!',
          lottieBuilder: Lottie.asset('assets/animations/success.json',
              fit: BoxFit.contain),
          titleAlign: TextAlign.center,
          msg: "Event deleted successfully",
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
                Navigator.pushNamed(context, '/navigator');
              },
              hslColor: HSLColor.fromColor(const Color(0xFF888789)),
              shadow: const BoxShadow(
                color: Color(0xFF505457),
              ),
              height: 50,
              elevation: 8,
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8F7F2),
                ),
              ),
            ),
          ],
        );
      } else if (response.statusCode == 500) {
        return Dialogs.materialDialog(
          context: context,
          title: 'Event deletion failed.',
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
  }

  @override
  void dispose() {
    super.dispose();
    _eventCodeController.dispose();
  }

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
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
                      token: token!,
                    )
                  : Container(),
            ),
            const SizedBox(height: 30.0),
            Column(
              children: [
                Visibility(
                  visible: widget.isInvited,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: PushableButton(
                            onPressed: () {
                              // Handle 'Cancel' button logic
                              Navigator.pop(context);
                            },
                            hslColor:
                                HSLColor.fromColor(const Color(0xFFB3AE99)),
                            shadow: const BoxShadow(
                              color: Color(0xFF554C3C),
                            ),
                            height: 50,
                            elevation: 8,
                            child: Text(
                              'Go Back',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF554C3C),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          child: PushableButton(
                            onPressed: () {
                              // Handle 'RSVP' button logic
                              _showRSVPPrompt((response) {
                                if (response == 'Yes') {
                                  _showEventCodePrompt(eventCode!,
                                      (eventCodeResponse) {
                                    sendRSVPStatus(
                                        eventCode!, eventCodeResponse);
                                  });
                                } else if (response == 'No') {
                                  sendRSVPStatus(eventCode!, response);
                                }
                              });
                            },
                            hslColor:
                                HSLColor.fromColor(const Color(0xFFB2BBDA)),
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Visibility(
                  visible: widget.isHost,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: PushableButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/rsvpDetails',
                                arguments: eventCode,
                              );
                            },
                            hslColor:
                                HSLColor.fromColor(const Color(0xFFB3AE99)),
                            shadow: const BoxShadow(
                              color: Color(0xFF554C3C),
                            ),
                            height: 50,
                            elevation: 8,
                            child: Text(
                              'Guest List',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF554C3C),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          child: PushableButton(
                            onPressed: () {
                              _showDeletePrompt(eventCode!);
                            },
                            hslColor:
                                HSLColor.fromColor(const Color(0xFFDCA1A1)),
                            shadow: const BoxShadow(
                              color: Color(0xFFAC1010),
                            ),
                            height: 50,
                            elevation: 8,
                            child: Text(
                              'Delete',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFAC1010),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
  const BuildEventCard(
      {Key? key, required this.specificEventDetails, required this.token})
      : super(key: key);

  final List<SpecificEventDetails> specificEventDetails;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB3AE99),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: specificEventDetails.length,
          itemBuilder: (context, index) {
            return CustomEventsListItem(
              eventName: specificEventDetails[index].eventName,
              eventAddress: specificEventDetails[index].eventAddress,
              eventDate: DateFormat.yMMMd().format(
                  DateTime.parse(specificEventDetails[index].eventDate)),
              eventTime: specificEventDetails[index].eventTime,
              eventDetail: specificEventDetails[index].eventDetail,
              eventRSVPBeforeDate: DateFormat.yMMMd().format(DateTime.parse(
                  specificEventDetails[index].eventRSVPBeforeDate)),
              eventRSVPBeforeTime:
                  specificEventDetails[index].eventRSVPBeforeTime,
              eventCode: specificEventDetails[index].eventCode,
            );
          },
        ),
      ),
    );
  }
}

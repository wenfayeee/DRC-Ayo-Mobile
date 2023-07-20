// ignore_for_file: use_build_context_synchronously

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:event_management_app/Functions/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GuestRSVPPage extends StatefulWidget {
  final String? token;
  final String eventCode;

  const GuestRSVPPage({Key? key, required this.eventCode, this.token})
      : super(key: key);

  @override
  State<GuestRSVPPage> createState() => _GuestRSVPPageState();
}

class _GuestRSVPPageState extends State<GuestRSVPPage> {
  String? token;
  String? email;
  String? eventCode;
  String dropdownValue = 'Invited';
  List<String> guestsRSVPYes = [];
  List<String> guestsRSVPNo = [];
  List<String> filteredGuests = [];

  @override
  void initState() {
    super.initState();
    getTokenFromSharedPrefs();
    decodeToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchGuestsRSVP(
        widget.eventCode); // Access the event code from widget object
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
    if (widget.token != null) {
      jwtDecodedToken = JwtDecoder.decode(widget.token!);
      if (jwtDecodedToken.containsKey('email')) {
        email = jwtDecodedToken['email'] as String?;
      }
    }
  }

  void fetchGuestsRSVP(String eventCode) async {
    try {
      var eventResponse = await http.get(
        Uri.parse('$getEventByEventCode$eventCode'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      var guestsYesResponse = await getGuestsResponse(getYesStatus, eventCode);
      var guestsNoResponse = await getGuestsResponse(getNoStatus, eventCode);

      if (eventResponse.statusCode == 200 &&
          guestsYesResponse.statusCode == 200 &&
          guestsNoResponse.statusCode == 200) {
        var eventJsonResponse = jsonDecode(eventResponse.body);
        var guestsYesJsonResponse =
            jsonDecode(guestsYesResponse.body) as List<dynamic>;
        var guestsNoJsonResponse =
            jsonDecode(guestsNoResponse.body) as List<dynamic>;

        setState(() {
          guestsRSVPYes = guestsYesJsonResponse
              .map((guest) => guest['invitee_email'] as String)
              .toList();
          guestsRSVPNo = guestsNoJsonResponse
              .map((guest) => guest['invitee_email'] as String)
              .toList();

          // Filter guests based on the dropdown value
          if (dropdownValue == 'Invited') {
            filteredGuests = guestsRSVPYes + guestsRSVPNo;
          } else if (dropdownValue == 'Accepted') {
            filteredGuests = guestsRSVPYes;
          } else if (dropdownValue == 'Declined') {
            filteredGuests = guestsRSVPNo;
          }
        });
      }
    } catch (error) {
      return Dialogs.materialDialog(
        context: context,
        title: 'Failed to fetch event details or guests RSVP',
        lottieBuilder:
            Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
        titleAlign: TextAlign.center,
        msg: 'Please try again later',
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

  Future<http.Response> getGuestsResponse(String url, String eventCode) {
    var formattedUrl = url.replaceFirst(':event_code', eventCode);
    return http.get(Uri.parse(formattedUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
  }

  @override
  Widget build(BuildContext context) {
    eventCode = ModalRoute.of(context)?.settings.arguments as String?;

    if (eventCode != null) {
      fetchGuestsRSVP(eventCode!);
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Guest List',
                    style: GoogleFonts.poppins(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF6B5F4A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    // Filter guests based on the new dropdown value
                    if (dropdownValue == 'Invited') {
                      filteredGuests = guestsRSVPYes + guestsRSVPNo;
                    } else if (dropdownValue == 'Accepted') {
                      filteredGuests = guestsRSVPYes;
                    } else if (dropdownValue == 'Declined') {
                      filteredGuests = guestsRSVPNo;
                    }
                  });
                },
                items: <String>['Invited', 'Accepted', 'Declined']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E3765),
                ),
                dropdownColor: const Color(0xFFB3AE99),
                elevation: 3,
                underline: Container(
                  height: 1,
                  color: const Color(0xFFB3AE99),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredGuests.length,
                  itemBuilder: (context, index) {
                    final guestEmail = filteredGuests[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB3AE99),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFB3AE99),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          guestEmail ?? '',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: const Color(0xFF1E3765),
                          ),
                        ),
                        subtitle: Text(
                          'Invitation Status: $dropdownValue',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF2A4F92),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

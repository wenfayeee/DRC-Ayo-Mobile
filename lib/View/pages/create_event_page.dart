// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:event_management_app/Functions/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventPage extends StatefulWidget {
  final String token;
  const CreateEventPage({required this.token, Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  String? token;
  String? email;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _venueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _rsvpDateController = TextEditingController();
  final _rsvpTimeController = TextEditingController();
  final _eventCodeController = TextEditingController();
  final _inviteeEmailController = TextEditingController();

  bool validateRSVPDateTime() {
    final eventDateTime =
        DateTime.parse('${_dateController.text}T${_timeController.text}');
    final rsvpDeadlineDateTime = DateTime.parse(
        '${_rsvpDateController.text}T${_rsvpTimeController.text}');

    if (rsvpDeadlineDateTime.isAfter(eventDateTime)) {
      setState(() {
        _rsvpDateController.text = '';
        _rsvpTimeController.text = '';
      });
      return false;
    }
    return true;
  }

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

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _venueController.dispose();
    _descriptionController.dispose();
    _rsvpDateController.dispose();
    _rsvpTimeController.dispose();
    _eventCodeController.dispose();
    _inviteeEmailController.dispose();
  }

  void addEvent() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_titleController.text.isNotEmpty &&
          _dateController.text.isNotEmpty &&
          _timeController.text.isNotEmpty &&
          _venueController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _rsvpDateController.text.isNotEmpty &&
          _rsvpTimeController.text.isNotEmpty &&
          _eventCodeController.text.isNotEmpty &&
          _inviteeEmailController.text.isNotEmpty) {
        var inviteeEmail = _inviteeEmailController.text;
        var inviteeEmailList =
            inviteeEmail.split(',').map((e) => e.trim()).toList();
        var regBody = {
          "event_name": _titleController.text,
          "event_date": _dateController.text,
          "event_time": _timeController.text,
          "event_address": _venueController.text,
          "event_detail": _descriptionController.text,
          "event_rsvp_before_date": _rsvpDateController.text,
          "event_rsvp_before_time": _rsvpTimeController.text,
          "event_code": _eventCodeController.text,
          "invitee_email": inviteeEmailList,
          "email": email,
        };

        try {
          var response = await http.post(
            Uri.parse(createEvent),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: jsonEncode(regBody),
          );

          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse is Map<String, dynamic>) {
            // Handle response as Map<String, dynamic>
            var statusCode = jsonResponse['statusCode'] as int?;
            if (response.statusCode == 201) {
              _titleController.clear();
              _dateController.clear();
              _timeController.clear();
              _venueController.clear();
              _descriptionController.clear();
              _rsvpDateController.clear();
              _rsvpTimeController.clear();
              _eventCodeController.clear();
              _inviteeEmailController.clear();
              return Dialogs.materialDialog(
                context: context,
                title: 'Success!',
                lottieBuilder: Lottie.asset('assets/animations/success.json',
                    fit: BoxFit.contain),
                titleAlign: TextAlign.center,
                msg:
                    'Great! You have successfully created the event. Your event details can be viewed through the homepage.',
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
                title: 'Event addition failed',
                lottieBuilder: Lottie.asset('assets/animations/error.json',
                    fit: BoxFit.contain),
                titleAlign: TextAlign.center,
                msg: 'Please try again.',
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
                title: 'Something went wrong.',
                lottieBuilder: Lottie.asset('assets/animations/error.json',
                    fit: BoxFit.contain),
                titleAlign: TextAlign.center,
                msg: 'Please try again later.',
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
          } else if (jsonResponse is List<dynamic>) {
            return Dialogs.materialDialog(
              context: context,
              title: 'Success!',
              lottieBuilder: Lottie.asset('assets/animations/success.json',
                  fit: BoxFit.contain),
              titleAlign: TextAlign.center,
              msg:
                  'Great! You have successfully created the event. Your event details can be viewed through the homepage.',
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
            return Dialogs.materialDialog(
              context: context,
              title: 'Something went wrong.',
              lottieBuilder: Lottie.asset('assets/animations/error.json',
                  fit: BoxFit.contain),
              titleAlign: TextAlign.center,
              msg: 'Please try again later.',
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
            title: 'Error',
            lottieBuilder: Lottie.asset('assets/animations/error.json',
                fit: BoxFit.contain),
            titleAlign: TextAlign.center,
            msg: 'Something went wrong. Please try again later.',
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
                hslColor: HSLColor.fromColor(const Color(0xFFB2BBDA)),
                shadow: const BoxShadow(
                  color: Color(0xFF1E3765),
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
    } else {
      return Dialogs.materialDialog(
        context: context,
        title: 'Error',
        lottieBuilder:
            Lottie.asset('assets/animations/error.json', fit: BoxFit.contain),
        titleAlign: TextAlign.center,
        msg:
            'RSVP deadline cannot be later than event date.\nPlease re-enter a valid date',
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
            hslColor: HSLColor.fromColor(const Color(0xFFB2BBDA)),
            shadow: const BoxShadow(
              color: Color(0xFF1E3765),
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
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFFFCF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 22.0, left: 25.0),
                        child: Text(
                          "Create Event",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF6B5F4A),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 22.0, right: 25.0, bottom: 2.0, left: 10.0),
                        child: AnimatedButton(
                          height: 50,
                          width: 100,
                          text: 'Create',
                          isReverse: true,
                          selectedTextColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          transitionType: TransitionType.LEFT_TO_RIGHT,
                          backgroundColor: const Color(0xFFB3AE99),
                          selectedBackgroundColor: const Color(0xFF6B5F4A),
                          borderColor: Colors.white,
                          borderRadius: 50,
                          borderWidth: 2,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          onPress: () {
                            addEvent();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      controller: _titleController,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000)),
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        hintText: 'Title',
                        contentPadding: EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC3C3C3),
                        ),
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter event title.';
                        }
                        if (value.length > 51) {
                          return 'Event name can be maximum \n50 characters only';
                        }
                        if (value.contains(RegExp(
                            r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 5.0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () async {
                              final currentDate = DateTime.now();
                              await showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    width: double.infinity,
                                    height: 300.0,
                                    child: CupertinoDatePicker(
                                      backgroundColor: const Color(0xFFFFFFFF),
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: currentDate,
                                      minimumDate: currentDate,
                                      maximumDate: DateTime(2100),
                                      onDateTimeChanged:
                                          (DateTime selectedDate) {
                                        _dateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(selectedDate);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select \nevent date.';
                              }
                              return null;
                            },
                            controller: _dateController,
                            keyboardType: TextInputType.datetime,
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000),
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Event Date',
                              labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000)),
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              hintText: 'Event Date',
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFC3C3C3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 5.0, right: 30.0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () async {
                              final selectedTime =
                                  await showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: const Color(0xFFFFFFFF),
                                    height: 300.0,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.time,
                                      initialDateTime: DateTime.now(),
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() {
                                          final formattedTime =
                                              DateFormat('HH:mm:ss')
                                                  .format(newTime);
                                          _timeController.text =
                                              formattedTime.toString();
                                        });
                                      },
                                    ),
                                  );
                                },
                              );
                              if (selectedTime != null) {
                                final formattedTime =
                                    DateFormat('HH:mm:ss').format(selectedTime);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select \nevent time.';
                              }
                              return null;
                            },
                            controller: _timeController,
                            keyboardType: TextInputType.datetime,
                            style: GoogleFonts.poppins(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF000000)),
                            decoration: const InputDecoration(
                              labelText: 'Event Time',
                              labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000)),
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              hintText: 'Time',
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFC3C3C3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      controller: _venueController,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000)),
                      decoration: const InputDecoration(
                        labelText: 'Venue',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        hintText: 'Venue',
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
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a venue/address.';
                        }
                        if (value.length > 101) {
                          return 'Event address can only be 100 characters maximum.';
                        }
                        if (value.contains(RegExp(
                            r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      maxLines: null,
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000)),
                      decoration: const InputDecoration(
                        labelText: 'Detailed Description',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        hintText: 'Detailed Description',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event description.';
                        }
                        if (value.length > 251) {
                          return 'Event detail can only be maximum 250 characters';
                        }
                        if (value.contains(RegExp(
                            r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 5.0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () async {
                              final DateTime? pickedDate =
                                  await showCupertinoModalPopup<DateTime>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300.0,
                                    child: CupertinoDatePicker(
                                      backgroundColor: const Color(0xFFFFFFFF),
                                      mode: CupertinoDatePickerMode.date,
                                      minimumDate: DateTime.now(),
                                      maximumDate: DateTime(2100),
                                      onDateTimeChanged: (DateTime? newDate) {
                                        if (newDate != null) {
                                          // Handle the selected date
                                          final formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(newDate);
                                          _rsvpDateController.text =
                                              formattedDate;
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                final formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                _rsvpDateController.text = formattedDate;
                              }
                            },
                            controller: _rsvpDateController,
                            keyboardType: TextInputType.datetime,
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000),
                            ),
                            decoration: const InputDecoration(
                              labelText: 'RSVP Date',
                              labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000)),
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              hintText: 'RSVP Date',
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFC3C3C3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFC3C3C3),
                              ),
                              alignLabelWithHint: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select RSVP \nbefore date';
                              }
                              if (!validateRSVPDateTime()) {
                                return 'Please select RSVP \nbefore date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 5.0, right: 30.0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () async {
                              final currentTime = DateTime.now();
                              final selectedTime =
                                  await showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: const Color(0xFFFFFFFF),
                                    height: 300.0,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.time,
                                      initialDateTime: currentTime,
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() {
                                          final formattedTime =
                                              DateFormat('HH:mm:ss')
                                                  .format(newTime);
                                          _rsvpTimeController.text =
                                              formattedTime.toString();
                                        });
                                      },
                                    ),
                                  );
                                },
                              );
                              if (selectedTime != null) {
                                setState(() {
                                  final formattedTime = DateFormat('HH:mm:ss')
                                      .format(selectedTime);
                                  _rsvpTimeController.text =
                                      formattedTime.toString();
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select RSVP \nbefore time.';
                              }
                              return null;
                            },
                            controller: _rsvpTimeController,
                            keyboardType: TextInputType.datetime,
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000),
                            ),
                            decoration: const InputDecoration(
                              labelText: 'RSVP Time',
                              labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000)),
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              hintText: 'RSVP Time',
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFC3C3C3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      controller: _eventCodeController,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000)),
                      decoration: const InputDecoration(
                        labelText: 'Event Code',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
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
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter an event code.';
                        }
                        if (value.length > 21) {
                          return 'Event code can only be maximum 20 characters.';
                        }
                        if (value.contains(RegExp(
                            r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      maxLines: null,
                      controller: _inviteeEmailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000)),
                      decoration: const InputDecoration(
                        labelText: "Invitee's Email",
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        hintText: "Invitee's Email",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter invitee email(s)';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        if (!value.contains('.com')) {
                          return 'Please enter a valid email address';
                        }
                        if (value.contains(RegExp(
                            r'\b(SELECT|UPDATE|DELETE|INSERT|DROP)\b'))) {
                          return 'Invalid input';
                        }
                        if (value
                            .contains(RegExp(r'<(?:\/?[a-z]|[a-z]+\s*\/?)>'))) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

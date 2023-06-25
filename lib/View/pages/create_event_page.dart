import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:switcher_button/switcher_button.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _titleController = TextEditingController();
  final _venueController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _rsvpController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _senderEmailController = TextEditingController();

  bool isGuestListVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFFFCF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Create Event',
                    style: GoogleFonts.poppins(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFA34EBB)),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Title',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
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
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _venueController,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Venue',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                const SizedBox(height: 5.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Event Date',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                const SizedBox(height: 5.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _timeController,
                    keyboardType: TextInputType.datetime,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Time',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                const SizedBox(height: 5.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _rsvpController,
                    keyboardType: TextInputType.datetime,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'RSVP Before',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                const SizedBox(height: 5.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: 'Detailed Description',
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                const SizedBox(height: 5.0),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _senderEmailController,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      hintText: "Sender's Email",
                      contentPadding: EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC3C3C3)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Guest List Visibility',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5B5F62),
                        ),
                      ),
                      SwitcherButton(
                        onColor: const Color(0xFF5B5F62),
                        offColor: const Color(0xFFC3C3C3),
                        value: isGuestListVisible,
                        onChange: (value) {
                          setState(() {
                            isGuestListVisible = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PushableButton(
                    hslColor: HSLColor.fromColor(
                      const Color(0xFFF8DBE0),
                    ),
                    shadow: const BoxShadow(
                      color: Color(0xFFF2A9B6),
                    ),
                    height: 50,
                    elevation: 8,
                    child: Text(
                      'Create Event',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF939393),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom widget for invited/hosted events in home_page
class CustomListItem extends StatelessWidget {
  const CustomListItem(
      {Key? key,
      required this.eventName,
      required this.eventAddress,
      required this.eventDate,
      required this.eventTime})
      : super(key: key);

  final String eventName;
  final String eventAddress;
  final String eventDate;
  final String eventTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 10.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventName,
            style: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E3765),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                IconsaxBold.location,
                size: 20.0,
                color: Color(0xFF6B5F4A),
              ),
              const SizedBox(width: 15.0),
              Text(
                eventAddress,
                style: GoogleFonts.poppins(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2A4F92),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Row(
            children: [
              const Icon(
                IconsaxBold.calendar_1,
                size: 20.0,
                color: Color(0xFF6B5F4A),
              ),
              const SizedBox(width: 15.0),
              Text(
                eventDate,
                style: GoogleFonts.poppins(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2A4F92),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Row(
            children: [
              const Icon(
                IconsaxBold.clock,
                size: 20.0,
                color: Color(0xFF6B5F4A),
              ),
              const SizedBox(width: 15.0),
              Text(
                eventTime,
                style: GoogleFonts.poppins(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2A4F92),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

abstract class Event {
  final String eventName;
  final String eventAddress;
  final String eventDate;
  final String eventTime;
  final String eventCode;

  Event({
    required this.eventName,
    required this.eventAddress,
    required this.eventDate,
    required this.eventTime,
    required this.eventCode,
  });
}

class InvitedEvent extends Event {
  InvitedEvent({
    required String eventName,
    required String eventAddress,
    required String eventDate,
    required String eventTime,
    required String eventCode,
  }) : super(
          eventName: eventName,
          eventAddress: eventAddress,
          eventDate: eventDate,
          eventTime: eventTime,
          eventCode: eventCode,
        );
}

class HostedEvent extends Event {
  HostedEvent({
    required String eventName,
    required String eventAddress,
    required String eventDate,
    required String eventTime,
    required String eventCode,
  }) : super(
          eventName: eventName,
          eventAddress: eventAddress,
          eventDate: eventDate,
          eventTime: eventTime,
          eventCode: eventCode,
        );
}

// Custom widget for invited/hosted events' details in event_details_page
class CustomEventsListItem extends StatelessWidget {
  const CustomEventsListItem(
      {Key? key,
      required this.eventName,
      required this.eventAddress,
      required this.eventDate,
      required this.eventTime,
      required this.eventDetail,
      required this.eventRSVPBeforeDate,
      required this.eventRSVPBeforeTime,
      required this.eventCode})
      : super(key: key);

  final String eventName;
  final String eventAddress;
  final String eventDate;
  final String eventTime;
  final String eventDetail;
  final String eventRSVPBeforeDate;
  final String eventRSVPBeforeTime;
  final String eventCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              eventName,
              style: GoogleFonts.poppins(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF000000),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Code',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF000000),
                  ),
                ),
                Text(
                  eventCode,
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2A4F92),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Date and Time',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF000000),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      eventDate,
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2A4F92),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 100.0)),
                    Text(
                      eventTime,
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2A4F92),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Venue',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF000000),
                  ),
                ),
                Text(
                  eventAddress,
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2A4F92),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detailed Description',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF000000),
                  ),
                ),
                Text(
                  eventDetail,
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2A4F92),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RSVP by',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF000000),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      eventRSVPBeforeDate,
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2A4F92),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 100.0)),
                    Text(
                      eventRSVPBeforeTime,
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2A4F92),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

abstract class EventDetails {
  String eventName;
  String eventDate;
  String eventTime;
  String eventAddress;
  String eventDetail;
  String eventRSVPBeforeDate;
  String eventRSVPBeforeTime;
  String eventCode;

  EventDetails(
      {required this.eventName,
      required this.eventDate,
      required this.eventTime,
      required this.eventAddress,
      required this.eventDetail,
      required this.eventRSVPBeforeDate,
      required this.eventRSVPBeforeTime,
      required this.eventCode});
}

class SpecificEventDetails extends EventDetails {
  SpecificEventDetails({
    required String eventName,
    required String eventDate,
    required String eventTime,
    required String eventAddress,
    required String eventDetail,
    required String eventRSVPBeforeDate,
    required String eventRSVPBeforeTime,
    required String eventCode,
  }) : super(
            eventName: eventName,
            eventDate: eventDate,
            eventTime: eventTime,
            eventAddress: eventAddress,
            eventDetail: eventDetail,
            eventRSVPBeforeDate: eventRSVPBeforeDate,
            eventRSVPBeforeTime: eventRSVPBeforeTime,
            eventCode: eventCode);
}

class EditEventDetails {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventAddress;
  final String eventDetail;
  final String eventRSVPBeforeDate;
  final String eventRSVPBeforeTime;
  final String eventCode;
  final String inviteeEmail;

  EditEventDetails({
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventAddress,
    required this.eventDetail,
    required this.eventRSVPBeforeDate,
    required this.eventRSVPBeforeTime,
    required this.eventCode,
    required this.inviteeEmail,
  });
}

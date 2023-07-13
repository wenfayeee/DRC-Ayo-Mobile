import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom widget for invited/hosted events in home_page
class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.eventName,
    required this.eventAddress,
    required this.eventDate,
    required this.eventTime,
  }) : super(key: key);

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
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E3765),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventAddress,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventDate,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventTime,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
        ],
      ),
    );
  }
}


class InvitedEvent {
  final String eventId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventAddress;
  final String eventCode;

  InvitedEvent({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventAddress,
    required this.eventCode,
  });
}

class HostedEvent {
  final String eventId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventAddress;
  final String eventCode;

  HostedEvent({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventAddress,
    required this.eventCode,
  });
}

// Custom widget for invited/hosted events' details in event_details_page
class CustomEventsListItem extends StatelessWidget {
  const CustomEventsListItem({
    Key? key,
    required this.eventName,
    required this.eventAddress,
    required this.eventDate,
    required this.eventTime,
    required this.eventDetail,
    required this.eventRsvpBeforeDate,
    required this.eventRsvpBeforeTime,
    required this.eventCode, // new parameter
  }) : super(key: key);

  final String eventName;
  final String eventAddress;
  final String eventDate;
  final String eventTime;
  final String eventDetail;
  final String eventRsvpBeforeDate;
  final String eventRsvpBeforeTime;
  final String eventCode;

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
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E3765),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventAddress,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventDate,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventTime,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventDetail,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventRsvpBeforeDate,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventRsvpBeforeTime,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventCode,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
        ],
      ),
    );
  }
}

class InvitedEventDetails {
  final String eventId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventAddress;
  final String eventDetail;
  final String eventRsvpBeforeDate;
  final String eventRsvpBeforeTime;
  final String eventCode;

  InvitedEventDetails({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventAddress,
    required this.eventDetail,
    required this.eventRsvpBeforeDate,
    required this.eventRsvpBeforeTime,
    required this.eventCode,
  });
}

class HostedEventDetails {
  final String eventId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventAddress;
  final String eventDetail;
  final String eventRsvpBeforeDate;
  final String eventRsvpBeforeTime;
  final String eventCode;

  HostedEventDetails({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventAddress,
    required this.eventDetail,
    required this.eventRsvpBeforeDate,
    required this.eventRsvpBeforeTime,
    required this.eventCode,
  });
}

// Custom widget for all events
class CustomAllEventsListItem extends StatelessWidget {
  const CustomAllEventsListItem({
    Key? key,
    required this.eventId,
    required this.eventName,
    required this.eventAddress,
    required this.eventDate,
    required this.eventTime,
    required this.eventDetail,
    required this.eventRsvpBeforeDate,
    required this.eventRsvpBeforeTime,
    required this.eventCode,
    required this.email,
  }) : super(key: key);

  final String eventId;
  final String eventName;
  final String eventAddress;
  final String eventDate;
  final String eventTime;
  final String eventDetail;
  final String eventRsvpBeforeDate;
  final String eventRsvpBeforeTime;
  final String eventCode;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 10.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            eventName,
            style: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E3765),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            eventAddress,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            eventDate,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            eventTime,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            eventDetail,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            eventRsvpBeforeDate,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            eventRsvpBeforeTime,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            eventCode,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            email,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
        ],
      ),
    );
  }
}

class AllEvents {
  final String eventId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventAddress;
  final String eventDetail;
  final String eventRsvpBeforeDate;
  final String eventRsvpBeforeTime;
  final String eventCode;
  final String email;

  AllEvents({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventAddress,
    required this.eventDetail,
    required this.eventRsvpBeforeDate,
    required this.eventRsvpBeforeTime,
    required this.eventCode,
    required this.email,
  });
}

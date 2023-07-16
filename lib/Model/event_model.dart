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
  const CustomEventsListItem({
    Key? key,
    required this.eventName,
    required this.eventAddress,
    required this.eventDate,
    required this.eventTime,
    required this.eventDetail,
    required this.eventRSVPBeforeDate,
    required this.eventRSVPBeforeTime,
    required this.eventCode,
  }) : super(key: key);

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
            eventRSVPBeforeDate,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2A4F92),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            eventRSVPBeforeTime,
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

abstract class EventDetails {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventAddress;
  final String eventDetail;
  final String eventRSVPBeforeDate;
  final String eventRSVPBeforeTime;
  final String eventCode;

  EventDetails({
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventAddress,
    required this.eventDetail,
    required this.eventRSVPBeforeDate,
    required this.eventRSVPBeforeTime,
    required this.eventCode,
  });
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
          eventCode: eventCode,
        );
}

// class InvitedEventDetails {
//   final String eventId;
//   final String eventName;
//   final String eventDate;
//   final String eventTime;
//   final String eventAddress;
//   final String eventDetail;
//   final String eventRsvpBeforeDate;
//   final String eventRsvpBeforeTime;
//   final String eventCode;

//   InvitedEventDetails({
//     required this.eventId,
//     required this.eventName,
//     required this.eventDate,
//     required this.eventTime,
//     required this.eventAddress,
//     required this.eventDetail,
//     required this.eventRsvpBeforeDate,
//     required this.eventRsvpBeforeTime,
//     required this.eventCode,
//   });
// }

// class HostedEventDetails {
//   final String eventId;
//   final String eventName;
//   final String eventDate;
//   final String eventTime;
//   final String eventAddress;
//   final String eventDetail;
//   final String eventRsvpBeforeDate;
//   final String eventRsvpBeforeTime;
//   final String eventCode;

//   HostedEventDetails({
//     required this.eventId,
//     required this.eventName,
//     required this.eventDate,
//     required this.eventTime,
//     required this.eventAddress,
//     required this.eventDetail,
//     required this.eventRsvpBeforeDate,
//     required this.eventRsvpBeforeTime,
//     required this.eventCode,
//   });
// }

// // Custom widget for all events
// class CustomDetailsListItem extends StatelessWidget {
//   const CustomDetailsListItem({
//     Key? key,
//     required this.eventName,
//     required this.eventAddress,
//     required this.eventDate,
//     required this.eventTime,
//     required this.eventDetail,
//     required this.eventRsvpBeforeDate,
//     required this.eventRsvpBeforeTime,
//     required this.eventCode,
//   }) : super(key: key);

//   final String eventName;
//   final String eventAddress;
//   final String eventDate;
//   final String eventTime;
//   final String eventDetail;
//   final String eventRsvpBeforeDate;
//   final String eventRsvpBeforeTime;
//   final String eventCode;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(18.0, 0.0, 10.0, 0.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
//           Text(
//             eventName,
//             style: GoogleFonts.poppins(
//               fontSize: 18.0,
//               fontWeight: FontWeight.w600,
//               color: const Color(0xFF1E3765),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
//           Text(
//             eventAddress,
//             style: GoogleFonts.poppins(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF2A4F92),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
//           Text(
//             eventDate,
//             style: GoogleFonts.poppins(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF2A4F92),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
//           Text(
//             eventTime,
//             style: GoogleFonts.poppins(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF2A4F92),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
//           Text(
//             eventDetail,
//             style: GoogleFonts.poppins(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF2A4F92),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
//           Text(
//             eventRsvpBeforeDate,
//             style: GoogleFonts.poppins(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF2A4F92),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
//           Text(
//             eventRsvpBeforeTime,
//             style: GoogleFonts.poppins(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF2A4F92),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
//           Text(
//             eventCode,
//             style: GoogleFonts.poppins(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF2A4F92),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



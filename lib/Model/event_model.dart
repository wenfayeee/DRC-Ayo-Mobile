class InvitedEvent {
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
  final String inviteeId;
  final String inviteeEmail;

  InvitedEvent({
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
    required this.inviteeId,
    required this.inviteeEmail,
  });
}

class HostedEvent {
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

  HostedEvent({
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

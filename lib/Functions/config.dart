//Main url
final url = 'http://10.0.2.2:3000/';

// User-account related configs
final register = url + 'users/register';
final login = url + 'users/login';
final forget = url + 'users/forgot-password';
final update = url + 'users/update';
final logout = url + 'users/logout';

// Event related configs
final createEvent = url + 'create_event/add';
final getEvent = url + 'create_event/get';
final getEventByEmail = url + 'create_event/email/';
final getEventByInviteeEmail = url + 'create_event/invite/';
final updateEvent = url + 'create_event/update/:event_code';
final deleteEvent = url + 'create_event/delete/:event_code';

// RSVP related configs
final addRSVP = url + 'rsvp/add';
final getRSVPByStatus = url + 'rsvp/status/:status';

//Main url
// final url = 'http://10.0.2.2:3000/'; // localhost
final url = 'http://192.168.18.71:3000/'; //my emulator IP address
// final url = 'http://192.168.100.28:3000/'; //condo IP
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
final getEventByEventCode = url + 'create_event/event/';

// RSVP related configs
final addRSVP = url + 'rsvp/add';
final getRSVPByStatus = url + 'rsvp/status/:status';

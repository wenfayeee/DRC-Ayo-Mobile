//Main url
// final url = 'http://10.0.2.2:3000/'; // localhost
final url = 'http://128.199.75.213:3000/'; //server public IP

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
final updateEvent = url + 'create_event/update/';
final deleteEvent = url + 'create_event/delete/';
final getEventByEventCode = url + 'create_event/event/';

// RSVP related configs
final addRSVP = url + 'rsvp/add';
final getRSVPByStatus = url + 'rsvp/status/:status';
final getYesStatus = url + 'rsvp/yes/:event_code';
final getNoStatus = url + 'rsvp/no/:event_code';

import 'dart:convert';

List<columbiaCalendarEvent> columbiaCalendarEventsFromJson(String str) =>
    List<columbiaCalendarEvent>.from(
        jsonDecode(str).map((x) => columbiaCalendarEvent.fromJson(x)));

class columbiaCalendarEvent {
  final DateTime startDateTime;
  final String title;
  final String description;
  final String dateTimeFormatted;
  final String location;

  columbiaCalendarEvent(
      {required this.startDateTime,
      required this.title,
      required this.description,
      required this.location,
      required this.dateTimeFormatted});

  factory columbiaCalendarEvent.fromJson(Map<String, dynamic> json) {
    return columbiaCalendarEvent(
      startDateTime: DateTime.parse(json['startDateTime']),
      title: json['title'],
      description: json['description'],
      location: json['location'],
      dateTimeFormatted: json['dateTimeFormatted'],
    );
  }
}

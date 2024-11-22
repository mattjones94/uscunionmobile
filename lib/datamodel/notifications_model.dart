import 'dart:convert';

List<NotificationsDataModel> notificationDataModelFromJson(String str) => List<NotificationsDataModel>.from(json.decode(str).map((x) => NotificationsDataModel.fromJson(x)));

class NotificationsDataModel {
  final String notification_title;
  final String notification_details;
  final String notification_time;
  final String notification_date_time;

  NotificationsDataModel({
    required this.notification_title,
    required this.notification_details,
    required this.notification_time,
    required this.notification_date_time,

  });

  factory NotificationsDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationsDataModel(
      notification_title: json['notification_title'],
      notification_details: json['notification_details'],
      notification_time: json['notification_time'],
      notification_date_time: json['notification_date_time'],

    );
  }
}

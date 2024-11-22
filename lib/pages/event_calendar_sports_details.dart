import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/calendar_athletics_event_datamodel.dart';
import 'package:uscunionmobile/datamodel/calendar_col_events_model.dart';
import 'package:uscunionmobile/pages/events_calendar.dart';
import 'package:intl/intl.dart';

class SportsCalendarDetails extends StatelessWidget {
  const SportsCalendarDetails({required this.sportsDetails});

  final MyRssItem sportsDetails;

  String formatRssPubDate(String pubDateStr) {
    try {
      final parsedDate = DateTime.parse(pubDateStr);
      final formattedDate = DateFormat.yMMMMd().format(parsedDate);
      return formattedDate; // Returns "October 18, 2019" format
    } catch (e) {
      // Handle any parsing errors, e.g., invalid date format
      print('Error formatting pubDate: $e');
      return ''; // Return an empty string or another default value in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.colors.uscuBurgendy,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppTheme.colors.uscuBurgendy,
              AppTheme.colors.veryLightBurgendy,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: Center(
                  child: Html(
                    data: "<h3 style=\"color:#FFFFFF;text-align: center;\">" +
                        sportsDetails.title +
                        "</h3>",
                    // textAlign: TextAlign.center,
                    // style: TextStyle(
                    //     fontSize: 22,
                    //     fontWeight: FontWeight.bold,
                    //     color: AppTheme.colors.usclBlue),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Html(
                  data: "<p style=\"color:white; text-align: center;\">" +
                      formatRssPubDate(sportsDetails.pubDate.toString()) +
                      "</p>",
                  // style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                  // height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Html(
                    data: "<p style=\"color:#FFFFFF; text-align: center;\">" +
                        sportsDetails.description +
                        "</p>",
                    // textAlign: TextAlign.center,
                    // style: TextStyle(
                    //     fontSize: 14, color: AppTheme.colors.usclBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

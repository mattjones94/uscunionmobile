import 'package:uscunionmobile/network_services/calendar_athletics_events_network.dart';
import 'package:uscunionmobile/datamodel/calendar_athletics_event_datamodel.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:uscunionmobile/pages/events_calendar.dart';

late Map<DateTime, List<MyRssItem>> events;

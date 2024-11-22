import 'dart:io';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uscunionmobile/custom/frosted_glass.dart';
import 'package:uscunionmobile/datamodel/calendar_col_events_model.dart';
//import 'package:usclhometest/models/calendar_sports_events_model.dart';
import 'package:uscunionmobile/network_services/calendar_columbia_network.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/pages/event_calendar_sports_details.dart';
import 'package:uscunionmobile/pages/events_calendar_col_details.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:uscunionmobile/datamodel/calendar_athletics_event_datamodel.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> with SingleTickerProviderStateMixin {
  // calendar variable for list of columbia events
  late Map<DateTime, List<columbiaCalendarEvent>> columbiaEvents;
  late Map<DateTime, List<MyRssItem>> rssEvents;
  Map<DateTime, List<MyRssItem>> _rssEvents = {};

  //calendar variables for rss data feed for athletics
  List<MyRssItem> rssItems = [];
  List<MyRssItem> filteredRssItems = [];

  DateTime? selectedDate;
  //late CalendarController _calendarController;

  //calendar variables
  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  //event count variable
  var eventCount = "";

  // event count set state

  changeEventCountLabel() {
    setState(() {
      eventCount = "This are ${_focusedDay.toString()} events today";
    });
  }

  List<columbiaCalendarEvent>? columbiaEventData;
  List<MyRssItem>? sportsEventData;

  bool isColumbiaCalendarLoaded = false;
  bool isSportsEventsLoaded = false;

  String numberOfEventsString = "Select A Date";

  //animation variables
  late AnimationController controller;
  late Animation<double> animation;

//init state for getting API Data for the scroller
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //animation loading
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.repeat();

    //fetch data from API
    getColumbiaEvents();

    //fetch data from sports rss
    fetchRssFeed();

    rssEvents = {};
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

//pulls the data from the service
  getColumbiaEvents() async {
    columbiaEventData =
        await ColumbiaCalenderNetworkService().getColumbiaCalendarPost();
    if (columbiaEventData != null) {
      if (mounted) {
        setState(() {
          isColumbiaCalendarLoaded = true;
          //isSportsEventsLoaded = true;
        });
      }
    }
  }

//get the data from the RSS feed for union athletics
  Future<void> fetchRssFeed() async {
    final url =
        Uri.parse('https://www.uscunionathletics.com/composite?print=rss');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final rssFeedXml = response.body;
      final parser = Xml2Json();
      parser.parse(rssFeedXml);

      final jsonString = parser.toParker();
      final Map<String, dynamic> rssFeedData = json.decode(jsonString);

      final items = rssFeedData['rss']['channel']['item'] as List<dynamic>;
      final List<MyRssItem> rssItems = [];

      for (final item in items) {
        final title = item['title'] as String;
        final description = item['description'] as String;
        final link = item['link'] as String;
        final pubDateStr = item['dc:date'] as String;

        final pubDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(pubDateStr);

        final rssItem = MyRssItem(
          title: title,
          description: description,
          link: link,
          pubDate: pubDate,
        );

        rssItems.add(rssItem);

        final dateKey = DateTime(pubDate.year, pubDate.month, pubDate.day);
        if (!rssEvents.containsKey(dateKey)) {
          rssEvents[dateKey] = [];
        }
        rssEvents[dateKey]!.add(rssItem);
      }

      setState(() {
        this.rssItems = rssItems;
        isSportsEventsLoaded = true;
      });
    } else {
      throw Exception('Failed to load RSS feed');
    }
  }

//compares the dates for the athletic events
  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
  //testing loading in data differently to show dots on calendar

  @override
  Widget build(BuildContext context) {
    return (isColumbiaCalendarLoaded && isSportsEventsLoaded)
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.colors.lightBurgendy,
                  Color.fromRGBO(0, 0, 0, 0.95)
                ],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                title: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Events",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  //container holding calendar, label and list
                  FrostedGlassBox(
                    theWidth: MediaQuery.of(context).size.width * 0.95,
                    theHeight: 385.0,
                    //calendar for all events
                    theChild: TableCalendar(
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          _selectedDay = selectDay;

                          // Filter RSS items for the selected date
                          filteredRssItems = rssItems.where((rssItem) {
                            return isSameDate(selectDay, rssItem.pubDate);
                          }).toList();

                          // Calculate the number of events
                          int numEvents = filteredRssItems.length;

                          // Add the Columbia events count
                          numEvents += columbiaEventData!.where((element) {
                            return compareDate(
                                selectDay, element.startDateTime);
                          }).length;

                          // Update the label for the number of events
                          if (numEvents == 0) {
                            numberOfEventsString = "There are no events today";
                          } else if (numEvents == 1) {
                            numberOfEventsString = "There is 1 event today";
                          } else {
                            numberOfEventsString =
                                "There are $numEvents event(s) today";
                          }
                        });
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(_selectedDay, date);
                      },
                      rowHeight: 40,
                      focusedDay: _selectedDay,
                      currentDay: DateTime.now(),
                      firstDay: DateTime(1990),
                      lastDay: DateTime(2050),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        headerPadding: EdgeInsets.all(15),
                        titleTextStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(
                          color: Colors.white,
                        ),
                        weekdayStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      eventLoader: (_selectedDay) {
                        // Filter Columbia events for the selected date
                        final columbiaEvents = columbiaEventData!
                            .where((event) =>
                                compareDate(_selectedDay, event.startDateTime))
                            .toList();

                        // Filter RSS events for the selected date
                        final sportsEvents = rssItems
                            .where((rssItem) =>
                                compareDate(_selectedDay, rssItem.pubDate))
                            .toList();

                        // Combine Columbia and RSS events
                        final combinedEvents = [
                          ...sportsEvents,
                          ...columbiaEvents
                        ];

                        return combinedEvents;
                      },
                      calendarStyle: CalendarStyle(
                        markerSize: 10,
                        markersMaxCount: 1,
                        markerDecoration: BoxDecoration(
                            color: AppTheme.colors.uscuBurgendy,
                            shape: BoxShape.circle),
                        isTodayHighlighted: true,
                        defaultTextStyle: TextStyle(color: Colors.white),
                        weekendTextStyle:
                            const TextStyle(color: Colors.white60),
                        selectedDecoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(color: Colors.white),
                      ),
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //container of the number of events label
                  FrostedGlassBox(
                    theHeight: 35.0,
                    theWidth: MediaQuery.of(context).size.width * 0.95,
                    theChild: Text(
                      numberOfEventsString,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Campus Events",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                decoration:
                                    BoxDecoration(color: Colors.transparent),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(8),
                                itemCount: columbiaEventData!.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return (compareDate(
                                          _selectedDay,
                                          columbiaEventData![index]
                                              .startDateTime))
                                      ? Divider()
                                      : Container();
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return (compareDate(
                                          _selectedDay,
                                          columbiaEventData![index]
                                              .startDateTime))
                                      ? ListTile(
                                          visualDensity: VisualDensity.compact,
                                          title: Text(
                                            columbiaEventData![index].title,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      ColumbiaEventsDetails(
                                                        columbiaDetails:
                                                            columbiaEventData![
                                                                index],
                                                      ))),
                                            );
                                          },
                                        )
                                      : Container();
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Sports Events",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                decoration:
                                    BoxDecoration(color: Colors.transparent),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  // return Padding(
                                  //   padding: EdgeInsets.only(top: 8.0),
                                  //   child: Text("No Sporting Events"),
                                  // );
                                  final rssItem = filteredRssItems[index];
                                  return ListTile(
                                    title: Text(
                                      rssItem.title,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                SportsCalendarDetails(
                                                  sportsDetails: rssItem,
                                                ))),
                                      );
                                    },
                                  );
                                },
                                itemCount: filteredRssItems.length,
                                shrinkWrap: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.colors.lightBurgendy,
                  ),
                  // child: ScaleTransition(
                  //   scale: animation,
                  //   alignment: Alignment.center,
                  //   child: SizedBox(
                  //     height: 200,
                  //     width: 200,
                  //     child: Image.asset('assets/images/bantum_default.png'),
                  //   ),
                  // ),
                ),
                Center(
                  child: Text(
                    "Loading Calendar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
            // appBar: AppBar(
            //   title: Text("Loading..."),
            //   backgroundColor: AppTheme.colors.uscuBurgendy,
            // ),
          );
  }

  bool compareDate(DateTime date, DateTime event) {
    return (date.day == event.day &&
        date.month == event.month &&
        date.year == event.year);
  }
}

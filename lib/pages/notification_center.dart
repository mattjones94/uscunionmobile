// import 'dart:html';
// import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/notifications_model.dart';
import 'package:uscunionmobile/network_services/notifications_network.dart';
import 'package:linkfy_text/linkfy_text.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({Key? key}) : super(key: key);

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  List<NotificationsDataModel>? unionNotificationData;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getUnionNotificationsPost();
  }

  //pulls the data from the firebase service
  getUnionNotificationsPost() async {
    unionNotificationData =
        await UnionNotificationsNetworkService().getUnionNotificationsPost();
    if (unionNotificationData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.uscuBurgendy,
        title: Text(
          "Notification Center",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: unionNotificationData?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1,
              color: Colors.black,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(unionNotificationData?[index].notification_title ??
                  "No Title"),
              subtitle: Text(
                  unionNotificationData?[index].notification_time ?? "No Time"),
              onTap: () => showModalBottomSheet(
                backgroundColor: Colors.grey.shade200,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      gradient: LinearGradient(
                          colors: [
                            AppTheme.colors.uscuBurgendy,
                            AppTheme.colors.veryLightBurgendy,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              width: 150,
                              height: 75,
                              image:
                                  AssetImage("assets/images/default_user.png"),
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Notification Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                          indent: 15,
                          endIndent: 15,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white.withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                unionNotificationData?[index]
                                        .notification_title ??
                                    "No Title",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.black,
                                indent: 10,
                                endIndent: 10,
                              ),
                              LinkifyText(
                                unionNotificationData?[index]
                                        .notification_details ??
                                    "No Details",
                                textAlign: TextAlign.center,
                                linkStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                                linkTypes: [
                                  LinkType.url,
                                ],
                                onTap: (link) {
                                  final Uri url = Uri.parse(link.value!);
                                  launchUrl(url);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

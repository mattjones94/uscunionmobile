import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uscunionmobile/datamodel/student_portal_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uscunionmobile/custom/app_theme.dart';

class StudentPortal extends StatefulWidget {
  StudentPortal({Key? key}) : super(key: key);

  final List<portalItem> portalItems = [
    portalItem(
      title: "BlackBoard",
      subText: "Sign in to BlackBoard",
      buttonText: "Click Here",
      url: "https://blackboard.sc.edu/",
    ),
    portalItem(
      title: "Self Service Carolina",
      subText:
          "Make payments, review financial aid, and check enrollment status here",
      buttonText: "Click Here",
      url: "https://my.sc.edu/",
    ),
    portalItem(
      title: "My Account Settings",
      subText:
          "Adjust account settings for email, updating password and changing DUO Authentication",
      buttonText: "Click Here",
      url: "https://my.sc.edu/vipid",
    ),
    portalItem(
      title: "University Email",
      subText: "Sign in to your univeristy email",
      buttonText: "Click Here",
      url: "https://www.sc.edu/studentemail",
    ),
  ];

  @override
  State<StudentPortal> createState() => _StudentPortalState();
}

class _StudentPortalState extends State<StudentPortal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Portal",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: AppTheme.colors.uscuBurgendy,
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(
                  widget.portalItems[index].title,
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.portalItems[index].subText,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.colors.uscuBurgendy,
                            minimumSize: Size(
                              double.infinity,
                              30,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          launchUrlString(widget.portalItems[index].url);
                        },
                        child: Text(widget.portalItems[index].buttonText)),
                  ],
                ),
              ),
          separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.grey,
              ),
          itemCount: widget.portalItems.length),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uscunionmobile/datamodel/faculty_model.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class FacultyPage extends StatelessWidget {
  final Faculty facultyMember;
  const FacultyPage({Key? key, required this.facultyMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.uscuBurgendy,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.colors.uscuBurgendy,
              AppTheme.colors.veryLightBurgendy
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: facultyMember.image != null &&
                      facultyMember.image.isNotEmpty
                  ? Image.network(
                      'https://uscmobileapps.com/uscumobile/uscudirectory/uscudirectoryimages/${facultyMember.image}',
                      height: 200,
                      width: 200,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/bantum_default.png',
                          height: 200,
                          width: 200,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/bantum_default.png',
                      height: 200,
                      width: 200,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "${facultyMember.firstname} ${facultyMember.lastname}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                facultyMember.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FacultyButtons(
                      icon: Icons.phone,
                      text: "Call",
                      address: facultyMember.phone,
                      isEmail: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FacultyButtons(
                      icon: Icons.email,
                      text: "Email",
                      address: facultyMember.email,
                      isEmail: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    FacultyDetails(
                      label: "Phone",
                      data: facultyMember.phone,
                    ),
                    // FacultyDetails(
                    //   label: "Office",
                    //   data: facultyMember.office,
                    // ),
                    FacultyDetails(
                      label: "Email",
                      data: facultyMember.email,
                      isBorder: false,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FacultyButtons extends StatelessWidget {
  final IconData icon;
  final String text;
  final String address;
  final bool isEmail;

  const FacultyButtons({
    Key? key,
    required this.icon,
    required this.text,
    required this.address,
    required this.isEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onPressed: () {
        if (isEmail) {
          launchUrlString("mailto:$address?");
        } else {
          launchUrlString("tel:$address");
        }
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 20,
          ),
          Text(text),
        ],
      ),
    );
  }
}

class FacultyDetails extends StatelessWidget {
  final String label;
  final String data;
  final bool isBorder;
  const FacultyDetails({
    Key? key,
    required this.label,
    required this.data,
    this.isBorder = true,
  }) : super(key: key);

  Border returnBorder(bool usesBorder) {
    if (usesBorder) {
      return Border(
        bottom: BorderSide(color: Colors.white, width: 1),
      );
    } else {
      return Border();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            label,
            maxLines: 1,
            style: TextStyle(color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                data,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      // child: ListTile(
      //   title: Text(
      //     label,
      //     maxLines: 1,
      //   ),
      //   trailing: Text(
      //     data,
      //     style: TextStyle(),
      //   ),
      //   visualDensity: VisualDensity(vertical: -4),
      //   style: ListTileStyle.drawer,
      // ),
      decoration: BoxDecoration(
        border: returnBorder(isBorder),
      ),
    );
  }
}

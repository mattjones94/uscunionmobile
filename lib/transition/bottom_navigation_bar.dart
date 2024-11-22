import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/pages/directory.dart';
import 'package:uscunionmobile/pages/events_calendar.dart';
import 'package:uscunionmobile/pages/home.dart';
import 'package:uscunionmobile/pages/resources.dart';
import 'package:uscunionmobile/pages/social_media.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  var appPages = [
    USCUHomePage(),
    Events(),
    Directory(),
    SocialMedia(),
    Resources(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appPages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.colors.uscuBurgendy,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
            backgroundColor: AppTheme.colors.uscuBurgendy,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Events',
            backgroundColor: AppTheme.colors.uscuBurgendy,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Directory',
            backgroundColor: AppTheme.colors.uscuBurgendy,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Social',
            backgroundColor: AppTheme.colors.uscuBurgendy,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Resources',
            backgroundColor: AppTheme.colors.uscuBurgendy,
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}

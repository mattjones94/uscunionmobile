import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/pages/directory.dart';
import 'package:uscunionmobile/pages/events_calendar.dart';
import 'package:uscunionmobile/pages/home.dart';
import 'package:uscunionmobile/pages/resources.dart';
import 'package:uscunionmobile/pages/social_media.dart';
import 'package:uscunionmobile/custom/custom_page_transition_animation.dart';
import 'package:uscunionmobile/navigation/menu_page_transition.dart';
import 'package:uscunionmobile/pages/menu.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int currentIndex = 0;
  var appPages = [
    USCUHomePage(),
    Events(),
    Directory(),
    Resources(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: appPages[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: AppTheme.colors.uscuBurgendy,
        shape: StadiumBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        //moving the action button and showing the bottom menu
        onPressed: () {
          // setState(() {
          //   buttonMoveUp = !buttonMoveUp;
          // });
          // showModalBottomSheet(
          //   backgroundColor: AppTheme.colors.lightBurgendy,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(
          //       top: Radius.circular(20),
          //     ),
          //     side: BorderSide(color: Colors.black, width: 2.0),
          //   ),
          //   context: context,
          //   builder: (context) => buildSheet(),
          // );
          Navigator.of(context).push(
            MyCustomAnimatedRoute(enterWidget: MenuScreen()),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        height: 60,
        color: AppTheme.colors.uscuBurgendy,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home_filled),
              color: currentIndex == 0
                  ? AppTheme.colors.lightBurgendy
                  : Colors.white,
              onPressed: () => _onNavItemTapped(0), // Set index for home
            ),
            IconButton(
              icon: Icon(Icons.calendar_month),
              color: currentIndex == 1
                  ? AppTheme.colors.lightBurgendy
                  : Colors.white,
              onPressed: () => _onNavItemTapped(1), // Set index for events
            ),
            SizedBox(), // Placeholder for the center space
            IconButton(
              icon: Icon(Icons.person),
              color: currentIndex == 2
                  ? AppTheme.colors.lightBurgendy
                  : Colors.white,
              onPressed: () => _onNavItemTapped(2), // Set index for directory
            ),
            IconButton(
              icon: Icon(Icons.shield),
              color: currentIndex == 3
                  ? AppTheme.colors.lightBurgendy
                  : Colors.white,
              onPressed: () => _onNavItemTapped(3), // Set index for resources
            ),
          ],
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

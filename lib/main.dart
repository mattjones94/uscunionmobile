import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/custom_bottom_nav_bar.dart';
import 'package:uscunionmobile/pages/athletics.dart';
import 'package:uscunionmobile/pages/clubs.dart';
import 'package:uscunionmobile/pages/gaming.dart';
import 'package:uscunionmobile/pages/information.dart';
import 'package:uscunionmobile/pages/library.dart';
import 'package:uscunionmobile/pages/maps.dart';
import 'package:uscunionmobile/pages/mental_health.dart';
import 'package:uscunionmobile/pages/nursing.dart';
import 'package:uscunionmobile/pages/todolist.dart';
import 'package:uscunionmobile/transition/bottom_navigation_bar.dart';
import 'package:uscunionmobile/custom/custom_bottom_nav_bar.dart';
import 'package:uscunionmobile/pages/home.dart';
import 'package:uscunionmobile/pages/student_portal.dart';
import 'transition/global_constants.dart' as global_constants;

//receive message when app is in background
// Future<void> backGroundNotificationHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   print(message.notification!.title);
// }

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backGroundNotificationHandler);

  runApp(const MyApp());
}

@override
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'USCU Mobile',
      theme: ThemeData(),
      routes: <String, WidgetBuilder>{
        // nine items
        global_constants.menuItems[0][0]: (context) => TodolistPage(),
        global_constants.menuItems[1][0]: (context) => StudentPortal(),
        global_constants.menuItems[2][0]: (context) => MyMapLauncher(),
        global_constants.menuItems[3][0]: (context) => Esports(),
        global_constants.menuItems[4][0]: (context) => AthleticsChoicePage(),
        global_constants.menuItems[5][0]: (context) => NursingProgram(),
        global_constants.menuItems[6][0]: (context) => LibraryPage(),
        global_constants.menuItems[7][0]: (context) => MentalHealth(),
        global_constants.menuItems[8][0]: (context) => ClubsPage(),
        global_constants.menuItems[9][0]: (context) => AppInformation(),
      },
      // home: BottomNavBar(),
      home: CustomBottomAppBar(),
    );
  }
}

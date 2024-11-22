import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/navigation/menu_page_transition.dart';
import 'package:uscunionmobile/pages/notification_center.dart';
import 'package:uscunionmobile/pages/todolist.dart';
import 'package:uscunionmobile/pages/student_portal.dart';
import 'package:uscunionmobile/pages/maps.dart';
import 'package:uscunionmobile/pages/gaming.dart';
import 'package:uscunionmobile/pages/athletics.dart';
import 'package:uscunionmobile/pages/nursing.dart';
import 'package:uscunionmobile/pages/library.dart';
import 'package:uscunionmobile/pages/mental_health.dart';
import 'package:uscunionmobile/pages/information.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class MenuOption {
  final IconData icon;
  final String label;
  final Widget pageLocation;

  MenuOption(
      {required this.icon, required this.label, required this.pageLocation});
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  // global_constants.menuItems[0][0]: (context) => TodolistPage(),
  // global_constants.menuItems[1][0]: (context) => StudentPortal(),
  // global_constants.menuItems[2][0]: (context) => MyMapLauncher(),
  // global_constants.menuItems[3][0]: (context) => Esports(),
  // global_constants.menuItems[4][0]: (context) => AthleticsChoicePage(),
  // global_constants.menuItems[5][0]: (context) => NursingProgram(),
  // global_constants.menuItems[6][0]: (context) => LibaryPage(),
  // global_constants.menuItems[7][0]: (context) => MentalHealth(),
  // global_constants.menuItems[8][0]: (context) => ClubsPage(),
  // global_constants.menuItems[9][0]: (context) => AppInformation(),

  final List<MenuOption> menuOptions = [
    MenuOption(
        icon: Icons.list_outlined,
        label: 'To Do List',
        pageLocation: TodolistPage()),
    MenuOption(
        icon: Icons.account_balance_outlined,
        label: 'Student Portal',
        pageLocation: StudentPortal()),
    MenuOption(icon: Icons.map, label: 'Maps', pageLocation: MyMapLauncher()),
    MenuOption(icon: Icons.gamepad, label: 'eSports', pageLocation: Esports()),
    MenuOption(
        icon: Icons.sports_baseball,
        label: 'Athletics',
        pageLocation: AthleticsChoicePage()),
    MenuOption(
        icon: Icons.medical_information,
        label: 'Nursing',
        pageLocation: NursingProgram()),
    MenuOption(icon: Icons.book, label: 'Library', pageLocation: LibraryPage()),
    MenuOption(
        icon: Icons.health_and_safety_rounded,
        label: 'Mental Health',
        pageLocation: MentalHealth()),
    // MenuOption(
    //     icon: Icons.info_rounded,
    //     label: 'Information',
    //     pageLocation: 'AppInformation()'),

    // Add more menu options as needed
  ];

  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;

  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;

  late Animation<double> animationToDecreasingCurve;

  @override
  void initState() {
    controllerToIncreasingCurve = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    controllerToDecreasingCurve = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: controllerToIncreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    animationToDecreasingCurve = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(
        parent: controllerToDecreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    controllerToIncreasingCurve.forward();

    super.initState();
  }

  bool closeFromTransition() {
    backPressed = true;
    controllerToDecreasingCurve.forward();
    Navigator.of(context).pop();
    return true;
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backPressed = true;
        controllerToDecreasingCurve.forward();
        return true;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          backPressed == false
              ? animationToIncreasingCurve.value
              : animationToDecreasingCurve.value,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(255, 109, 118, 1),
                AppTheme.colors.uscuBurgendy
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 150,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            label: Text(
                              'Notifications',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationCenter(),
                                ),
                              );
                            },
                            icon: Icon(Icons.flag, color: Colors.white),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     TextButton.icon(
                      //       label: Text(
                      //         'Settings',
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.white),
                      //       ),
                      //       onPressed: () {
                      //         // Add your action code here
                      //         closeFromTransition();
                      //       },
                      //       icon: Icon(
                      //         Icons.settings,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            label: Text(
                              'Information',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppInformation(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.50,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: menuOptions.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showBottomSheetPage(
                                      context, menuOptions[index].pageLocation);
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      menuOptions[index].label,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(115, 0, 10, 1.0),
                                      ),
                                    ),
                                    MenuTile(option: menuOptions[index]),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // color: Colors.blue,
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              closeFromTransition();
                            }),
                            child: Container(
                              height: 45,
                              width: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(143, 255, 255, 255),
                                  width: 5,
                                ),
                              ),
                              child: Container(
                                child: Icon(
                                  Icons.close,
                                  color: Color.fromRGBO(115, 0, 10, 1.0),
                                  size: 22,
                                ),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final MenuOption option;

  MenuTile({required this.option});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        height: 45,
        width: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color.fromARGB(143, 255, 255, 255),
            width: 5,
          ),
        ),
        child: Container(
          child: Icon(
            option.icon,
            color: Color.fromRGBO(115, 0, 10, 1.0),
            size: 22,
          ),
          height: 60,
          width: 60,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white30),
        ),
      ),
    );
  }
}

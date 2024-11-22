import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
// import 'package:usclhometest/pages/notifications.dart';
//import 'package:usclhometest/pages/resources.dart';
import 'package:http/http.dart' as http;
import 'package:uscunionmobile/custom/theme_colors.dart';
import 'package:uscunionmobile/datamodel/home_news_data_model.dart';
import 'package:uscunionmobile/pages/notification_center.dart';
import 'package:uscunionmobile/transition/global_constants.dart'
    as global_constants;
//     as global_constants;
import 'package:uscunionmobile/network_services/home_news_network.dart';
import 'package:uscunionmobile/pages/blog.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:usclhometest/network_services/local_notification_appearance_network.dart';

late Timer currentStateTimer;

class USCUHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return USCUHomePageState();
  }
}

class USCUHomePageState extends State<USCUHomePage> {
  List<Widget> dotList = [];

  final Widget defaultDot = Padding(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
    child: Opacity(
      opacity: .75,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          shape: BoxShape.circle,
        ),
      ),
    ),
  );

  final Widget selectedDot = Padding(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
    child: Opacity(
      opacity: 1.0,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    ),
  );

  void animateDots(bool isMounted, int currentValue) {
    // if (currentValue + 1 >= newsData!.length) {
    //   currentValue = 0;
    // } else {
    //   currentValue++;
    // }

    dotList.clear();

    if (isMounted) {
      for (int index = 0; index < newsData!.length; index++) {
        // print("The currentValue is: $currentValue");
        // print(
        //     "The current index is: $index and the news data is ${newsData![index].newstitle}");

        if (index == currentValue) {
          dotList.add(selectedDot);
        } else {
          dotList.add(defaultDot);
        }
      }
    }
  }

  //button variables
  double _angle = 45.0;
  Color iconButtonColor = AppTheme.colors.usclGold;

  //moving the floating action button variables
  bool buttonMoveUp = false;

  //news api variables
  List<NewsDataModel>? newsData;
  var isLoaded = false;

  // news pageController
  PageController _pageController = PageController(viewportFraction: 0.85);
  //init state for getting API Data for the scroller
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch data from API
    getData();

    // //firebase foreground notification fetch
    // FirebaseMessaging.instance.getInitialMessage();

    // //listening for firebase message
    // FirebaseMessaging.onMessage.listen((message) {
    //   if (message.notification != null) {
    //     print(message.notification!.body);
    //     print(message.notification!.title);
    //   }
    //   LancasterFirebaseNotification.displayNotification(message);
    // });
  }

  @override
  void dispose() {
    dotList.clear();

    _pageController.dispose();
    currentStateTimer.cancel();

    super.dispose();
  }

//pulls the data from the service
  getData() async {
    newsData = await NewsRemoteService().getNewsPost();
    if (newsData != null) {
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }

      currentStateTimer = Timer(Duration(seconds: 5), () {
        animateNews(_pageController, newsData!.length, 0);

        animateDots(_pageController.hasClients, 0);
      });
    }
  }

//application view
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppTheme.colors.uscuBurgendy, AppTheme.colors.uscuBlack],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light),
          title: const Text(
            "USC Union Mobile",
            style: TextStyle(fontSize: 25),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: homePageView(_pageController, animateDots),

        //  all code for the floating action button
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppTheme.colors.uscuBurgendy,
        //   shape: StadiumBorder(
        //     side: BorderSide(color: Colors.black, width: 2),
        //   ),
        //   child: Icon(
        //     Icons.menu,
        //     color: Colors.black,
        //   ),
        //   //moving the action button and showing the bottom menu
        //   onPressed: () {
        //     showModalBottomSheet(
        //       backgroundColor: AppTheme.colors.lightBurgendy,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.vertical(
        //           top: Radius.circular(20),
        //         ),
        //         side: BorderSide(color: Colors.black, width: 2.0),
        //       ),
        //       context: context,
        //       builder: (context) => buildSheet(),
        //     );
        //   },
        // ),
      ),
    );
  }

  void animateNews(
      PageController _pageController, int lengthOfArray, int currentValue) {
    if (_pageController.hasClients) {
      if (currentValue + 1 < lengthOfArray) {
        _pageController.animateToPage(_pageController.page!.toInt() + 1,
            duration: Duration(
              seconds: 1,
            ),
            curve: Curves.ease);
      } else {
        _pageController.animateToPage(0,
            duration: Duration(
              seconds: 1,
            ),
            curve: Curves.ease);
      }
    }
  }

  // returns list of widgets for row container in news
  // List<Widget> buildNewsDotRow(int length, int currentIndex) {
  //   List<Widget> dotRow = [];
  //   for (int i = 0; i < length; i++) {
  //     dotRow.add(Padding(
  //       padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
  //       child: Opacity(
  //         opacity: (i == currentIndex) ? 1.0 : .75,
  //         child: Container(
  //           width: 5,
  //           height: 5,
  //           decoration: BoxDecoration(
  //             color: (i == currentIndex) ? Colors.white : Colors.grey.shade400,
  //             shape: BoxShape.circle,
  //           ),
  //         ),
  //       ),
  //     ));
  //   }
  //   return dotRow;
  // }

  Widget homePageView(PageController _pageController, void dotAnimator) {
    // whole homepage
    return Column(
      children: [
        Image(
            image: AssetImage('assets/images/uscu_banner.png'),
            width: MediaQuery.of(context).size.width,
            height: 175,
            fit: BoxFit.fitHeight),
        const Divider(
          height: 10,
          thickness: 1.5,
          indent: 20,
          endIndent: 20,
          color: Colors.white,
        ),
        Container(
          height: 110,
          padding: (EdgeInsets.all(6.0)),
          child: SingleChildScrollView(
            child: Text(
              '''Welcome to the USCU Mobile app on Android! This will be your one stop for all your USCU Information from here you will be able to find all our faculty and staff, read the campus blog and see all upcoming events on campus! This is the place to be to stay connected!
              ''',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
        ),
        const Divider(
          height: 10,
          thickness: 1.5,
          indent: 50,
          endIndent: 50,
          color: Colors.white,
        ),

        //news scroller container

        Visibility(
          visible: isLoaded,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: ((value) {
                    // print("Page changed + value is $value");
                    // if (dotList.isEmpty) {
                    // print("dotList is empty");
                    // }

                    currentStateTimer.cancel();
                    setState(() {
                      animateDots(isLoaded, value);
                    });

                    currentStateTimer = Timer(
                        const Duration(
                          seconds: 5,
                        ), (() {
                      setState(() {
                        animateNews(_pageController, newsData!.length, value);
                      });
                    }));
                  }),
                  itemCount: newsData?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.uscuBurgendy,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.black54),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: Image.network(
                                    "https://uscmobileapps.com/uscumobile/uscunews/uscunewsimages/" +
                                        newsData![index].newsimage),
                                title: Text(
                                  newsData![index].newstitle,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  newsData![index].newsinfo,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: dotList,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: (mounted)
                    ? (Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: dotList,
                      ))
                    : Container(
                        child: Text("Loading"),
                      ),
              )
            ],
          ),
        ),

        //blog Text
        const Text(
          'Stay in the know with our campus blog!',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BlogPage()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                AppTheme.colors.lightBurgendy,
              ),
              elevation: MaterialStateProperty.all(3),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text(
              "Click here for more information!",
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        )

        //container for blog button
        // Container(
        //   width: MediaQuery.of(this.context).size.width * 0.8,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => BlogPage()),
        //       );
        //     },
        //     style: ElevatedButton.styleFrom(
        //       primary: Colors.black54,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(25),
        //           side: BorderSide(color: Colors.white)),
        //       elevation: 15.0,
        //     ),
        //     child: const Padding(
        //       padding: EdgeInsets.all(6.0),
        //       child: Text(
        //         'Read our blog here!',
        //         style: TextStyle(fontSize: 16),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// This is the pullup menu
Widget buildSheet() => GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150.0,
        mainAxisExtent: 150.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.5,
      ),
      itemCount: global_constants.menuItems.length,
      itemBuilder: (context, index) => InkWell(
        onTap: (() {
          Navigator.pushNamed(context, global_constants.menuItems[index][0]);
        }),
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: AppTheme.colors.lightBurgendy,
                  width: 2.0,
                  style: BorderStyle.solid)),
          child: Column(children: [
            SizedBox(
              child: Image(
                image: AssetImage(global_constants.menuItems[index][1]),
              ),
            ),
            Center(
              child: Text(
                global_constants.menuItems[index][0],
                style: TextStyle(
                    color: AppTheme.colors.uscuBurgendy,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 14),
              ),
            ),
          ]),
        ),
      ),
    );

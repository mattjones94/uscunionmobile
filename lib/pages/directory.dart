import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uscunionmobile/datamodel/faculty_model.dart';
import 'package:uscunionmobile/custom/directory_tiles.dart';
import 'package:uscunionmobile/custom/search_box.dart';
import 'package:uscunionmobile/custom/app_theme.dart';

// Directory page widget
class Directory extends StatefulWidget {
  Directory({Key? key}) : super(key: key);

  // This controller is used to access data from the text field across the widget.
  final TextEditingController _textController = TextEditingController();

  // returns the data from the API
  Future<List<Faculty>> fetchFaculty() async {
    // gets the data
    final response = await http
        .get(Uri.parse("https://uscmobileapps.com/loaddirectorydata_USCU.php"));
    //.get(Uri.parse("https://uscmobileapps.com/loaddirectorydata_USCU.php"));

    // returns the data as a List if we successfully pulled it
    if (response.statusCode == 200) {
      List<Faculty> facultyList = [];
      final decodedJson = jsonDecode(response.body);
      for (final faculty in decodedJson) {
        facultyList.add(Faculty.fromJson(faculty));
      }
      return facultyList;
    }
    // otherwise we throw an exception
    else {
      throw Exception("failed to access faculty api");
    }
  }

  // stores previousFilterValue to determine how to filter the list
  String previousFilterValue = "";

  // this stores the faculty data so I can reload it if the user starts deleting
  // characters
  List<Faculty> facultyStore = [];

  // used essentially as an InitState function for FutureBuilder
  bool firstRun = true;

  List<Faculty> filterFaculty(String filterValue, List<Faculty> facultyList) {
    // if the user is typing in more data we will only filter from what
    // we have already filtered
    if (filterValue.length > previousFilterValue.length) {
      previousFilterValue = filterValue;

      return filterSpecificList(filterValue, facultyList);
    }

    // if the user is deleting characters from their search
    // we will reset the list and start filtering again
    else {
      facultyList = facultyStore;

      previousFilterValue = filterValue;

      return filterSpecificList(filterValue, facultyList);
    }
  }

  // Used to actually filter the list based on the filterValue
  List<Faculty> filterSpecificList(
      String filterValue, List<Faculty> facultyList) {
    // list to return
    List<Faculty> filteredList = [];

    facultyList = facultyStore;

    for (int index = 0; index < facultyList.length; index++) {
      if (facultyList[index]
              .firstname
              .toLowerCase()
              .contains(filterValue.toLowerCase(), 0) ||
          facultyList[index]
              .lastname
              .toLowerCase()
              .contains(filterValue.toLowerCase(), 0)) {
        filteredList.add(facultyList[index]);
        print("first name is ${facultyList[index].firstname}");
        print("last name is ${facultyList[index].lastname}");
      }
    }
    return filteredList;
  }

  @override
  State<Directory> createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory>
    with SingleTickerProviderStateMixin {
  late Future<List<Faculty>> FutureFacultyList;
  static late List<Faculty> facultyList;

  //animation variables
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    //animation loading
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.repeat();

    //loading faculty data
    FutureFacultyList = widget.fetchFaculty();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();

    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FutureFacultyList,
      builder: (BuildContext context, AsyncSnapshot<List<Faculty>> snapshot) {
        if (snapshot.hasData) {
          // list of widgets that goes on the column
          List<Widget> columnList = [];

          // initState for future builder
          if (widget.firstRun) {
            // casts Faculty and sorts them
            facultyList = snapshot.data as List<Faculty>;
            facultyList.sort(((a, b) {
              return a.lastname
                  .toLowerCase()
                  .compareTo(b.lastname.toLowerCase());
            }));

            // stores the faculty
            widget.facultyStore = facultyList;

            // disables the firstRun
            widget.firstRun = false;
          }

          String previousFirstCharacter = 'a';

          // loops through to add header tiles if needed.
          for (int index = 0; index < facultyList.length; index++) {
            if (previousFirstCharacter != facultyList[index].lastname[0]) {
              columnList.add(DifferentTile(
                  characterChange: facultyList[index].lastname[0]));
            }
            columnList.add(FacultyListItem(facultyMember: facultyList[index]));
            previousFirstCharacter = facultyList[index].lastname[0];
          }

          // actual UI build
          return Container(
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
              body: SingleChildScrollView(
                child: Column(
                  children: columnList,
                ),
              ),
              appBar: PreferredSize(
                preferredSize: Size(
                  double.infinity,
                  100,
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  title: Text("Directory", style: TextStyle(fontSize: 25)),
                  bottom: PreferredSize(
                    preferredSize: Size(
                      MediaQuery.of(context).size.width,
                      100,
                    ),
                    child: SearchBox(
                      changeFunction: () {
                        setState(() {
                          facultyList = widget.filterFaculty(
                            widget._textController.text,
                            facultyList,
                          );
                        });
                      },
                      controller: widget._textController,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        // This gives a default return that can be used while we wait
        else {
          return Scaffold(
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
                    "Loading Directory",
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
      },
    );
  }
}

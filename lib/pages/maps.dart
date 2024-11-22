import 'package:map_launcher/map_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/webfeed.dart';
import 'package:uscunionmobile/datamodel/maps_data_model.dart';

class MyMapLauncher extends StatelessWidget {
  // final coordinates = Coords(7.296389, 80.635);
  // final title = "Kandy";
  // final description = "Kandy, Sri Lanka";

  MyMapLauncher({Key? key}) : super(key: key);

  // showMarkerWithFirstMap() async {
  //   final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
  //   await availableMaps.first.showMarker(
  //     coords: coordinates,
  //     title: title,
  //   );
  // }

  // showDirectionWithFirstMap() async {
  //   final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
  //   await availableMaps.first.showDirections(
  //     destination: coordinates,
  //   );
  // }

  // checkAvailableAndShow() async {
  //   bool isGoogleMaps =
  //       await MapLauncher.isMapAvailable(MapType.google) ?? false;
  //   if (isGoogleMaps) {
  //     await MapLauncher.showMarker(
  //       mapType: MapType.google,
  //       coords: coordinates,
  //       title: title,
  //       description: description,
  //     );
  //   }
  // }

  // openMapsSheet(BuildContext context) async {
  //   try {
  //     final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

  //     showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SafeArea(
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: <Widget>[
  //                 for (AvailableMap map in availableMaps)
  //                   ListTile(
  //                     onTap: () => map.showDirections(
  //                       destination: coordinates,
  //                     ),
  //                     title: Text(map.mapName),
  //                     leading: SvgPicture.asset(
  //                       map.icon,
  //                       height: 30.0,
  //                       width: 30.0,
  //                     ),
  //                   ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  var uscuMapLocations = [
    MapLocations(
        title: "Main Building",
        latitude: 34.71608033193246,
        longitude: -81.61970223070767),
    //34.71608033193246, -81.61970223070767
    MapLocations(
        title: "William J Whitener Building",
        latitude: 34.71790337413957,
        longitude: -81.62102943070767),
    //34.71790337413957, -81.62102943070767
    MapLocations(
        title: "USC Union Laurens Location",
        latitude: 34.50629864547837,
        longitude: -82.00983447304131),
    //34.50629864547837, -82.00983447304131
    MapLocations(
        title: "Union County Carnegie Library",
        latitude: 34.71324287662578,
        longitude: -81.62059060187234),
    //34.71324287662578, -81.62059060187234
    MapLocations(
        title: "Mens Soccer Field",
        latitude: 34.83709621646966,
        longitude: -81.6817240595406),
    //34.83709621646966, -81.6817240595406
    MapLocations(
        title: "Mens Baseball Field",
        latitude: 34.833434418820644,
        longitude: -81.68817355954063),
    //34.833434418820644, -81.68817355954063
    MapLocations(
        title: "Womens Softball Field",
        latitude: 34.712755976885575,
        longitude: -81.63044680187231),
    //34.712755976885575, -81.63044680187231
    MapLocations(
        title: "Womens Volleyball Court",
        latitude: 34.71643681822411,
        longitude: -81.6204756307077),
    //34.71643681822411, -81.6204756307077
    MapLocations(
        title: "Student Housing- 101 West",
        latitude: 34.71508411414833,
        longitude: -81.62387106495048),
    //34.71508411414833, -81.62387106495048
    MapLocations(
        title: "Student Housing- University Commons at Lakeside",
        latitude: 34.7319837011129,
        longitude: -81.61325853070737),
    //34.7319837011129, -81.61325853070737
    MapLocations(
        title: "Student Housing- University Place Residences",
        latitude: 34.71730045565302,
        longitude: -81.62147777303682),
    //34.71730045565302, -81.62147777303682
    MapLocations(
        title: "Student Housing- Bantams Coop",
        latitude: 34.71565807533738,
        longitude: -81.62248163070771),
    //34.71565807533738, -81.62248163070771
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USC Union Maps'),
        backgroundColor: AppTheme.colors.uscuBurgendy,
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Kandy - Coordinates',
      //         style: Theme.of(context).textTheme.headline5,
      //       ),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       Text(
      //         coordinates.latitude.toString(),
      //         style: Theme.of(context).textTheme.headline5,
      //       ),
      //       Text(
      //         coordinates.longitude.toString(),
      //         style: Theme.of(context).textTheme.headline5,
      //       ),
      //       const SizedBox(
      //         height: 40,
      //       ),
      //       ElevatedButton(
      //           style: ButtonStyle(
      //               backgroundColor: MaterialStateProperty.all(Colors.red)),
      //           onPressed: () => showMarkerWithFirstMap(),
      //           child: const Text('Show Marker With First Map')),
      //       ElevatedButton(
      //           onPressed: () => showDirectionWithFirstMap(),
      //           child: const Text('Show Direction With First Map')),
      //       ElevatedButton(
      //           style: ButtonStyle(
      //               backgroundColor: MaterialStateProperty.all(Colors.orange)),
      //           onPressed: () => checkAvailableAndShow(),
      //           child: const Text('Check Availability And Show Marker')),
      //       ElevatedButton(
      //           style: ButtonStyle(
      //               backgroundColor: MaterialStateProperty.all(Colors.green)),
      //           onPressed: () => openMapsSheet(context),
      //           child: const Text('Show Available Maps')),
      //     ],
      //   ),
      // ),
      body: Center(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.black54),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "USC Union has many locations that offer benefits to our students. Please use the button below to select where you would like to go.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => buildLocationsSheet(context),
            //enableDrag: true,
            //isScrollControlled: true,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
          );
        },
        backgroundColor: AppTheme.colors.uscuBurgendy,
        child: Icon(Icons.map),
      ),
    );
  }

  Widget buildLocationsSheet(BuildContext context) => DraggableScrollableSheet(
        initialChildSize: 1,
        //minChildSize: 0.5,
        //maxChildSize: 0.8,
        expand: true,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white),
          child: 
          
          
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppTheme.colors.uscuBurgendy,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      "USC Union Locations",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(),
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(10),
                  itemCount: uscuMapLocations.length,
                  itemBuilder: (context, index) => ListTile(
                      tileColor: Colors.white,
                      trailing: Icon(
                        Icons.location_pin,
                        color: AppTheme.colors.uscuBurgendy,
                      ),
                      title: Text(uscuMapLocations[index].title),
                      onTap: () async {
                        var schoolLocation = Coords(
                            uscuMapLocations[index].latitude,
                            uscuMapLocations[index].longitude);
                        final List<AvailableMap> availableMaps =
                            await MapLauncher.installedMaps;
                        await availableMaps.first.showDirections(
                          //destination: (latitude)
                          destination: schoolLocation,
                        );
                      },),
                ),
              ],
            ),
          ),
        )
      );
}

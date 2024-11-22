import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/resource_data_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class Resources extends StatefulWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  final List<ResourceModel> resourceInformation = [
    ResourceModel(
      group: 'Local Resources',
      title: 'City Public Safety & Fire',
      location: '215 Thompson Blvd',
      email: 'No Email',
      fax: 'No Fax',
      phone: '(864) 429-1710',
    ),
    ResourceModel(
      group: 'Local Resources',
      title: 'County Sheriff Office',
      location: '210 W. Main St.',
      email: 'No Email',
      fax: 'No Fax',
      phone: '(864) 429-1612',
    ),
    ResourceModel(
      group: 'Local Resources',
      title: 'Union County EMS',
      location: '1262 Duncan Bypass',
      email: 'No Email',
      fax: 'No Fax',
      phone: '(864) 427-0574',
    ),
    ResourceModel(
      group: 'Local Resources',
      title: 'Union Medical Center',
      location: '322 W. South St.',
      email: 'No Email',
      fax: 'No Fax',
      phone: '(864) 301-2000',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Admissions, Registrar and Enrollment',
      location: 'Student Service Building',
      email: 'greerm@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8011',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Athletic Department',
      location: '309 E Academy Street',
      email: 'simmonzb@mailbox.sc.edu',
      fax: '(864) 424-8090',
      phone: '(864) 762-0039',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'USC Aiken School of Nursing at the Union Campus',
      location: '322 E. Main St.',
      email: 'edwar342@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8030',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Financial Aid',
      location: 'Student Services Building',
      email: 'reholcom@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8024',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Academic and Student Affairs',
      location: '401 E. Main St.',
      email: 'azizma@mailbox.sc.edu',
      fax: '(864) 424-8085',
      phone: '(864) 424-8061',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Development Department',
      location: '309 E. Academy St.',
      email: 'alsmith@mailbox.sc.edu',
      fax: '(864) 424-8092',
      phone: '(864) 979-1818',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Carnegie Library',
      location: '300 E. South St.',
      email: 'info@unionlibrary.org',
      fax: 'No Fax',
      phone: '(864) 427-7140',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Facilities/Maintenance',
      location: '309 E Academy St',
      email: 'ballingr@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(803) 447-1265',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Bookstore',
      location: '311 E Main St',
      email: 'trblack@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8080',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Palmetto College',
      location: '315 E Main St',
      email: 'sumnerm@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8032',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Business Department',
      location: '309 E Main St',
      email: 'kavarne@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8029',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Student Success Center ',
      location: '401 E Main St',
      email: 'englance@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8017',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'IT',
      location: '401 E Main St',
      email: 'jdblack@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8081',
    ),
    ResourceModel(
      group: 'University Resources',
      title: 'Security',
      location: '322 E Main St',
      email: 'gregorga@mailbox.sc.edu',
      fax: 'No Fax',
      phone: '(864) 424-8000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "Resources",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: GroupedListView<dynamic, String>(
          //Resource array
          elements: resourceInformation,

          // group by
          groupBy: (element) => element.group,

          groupSeparatorBuilder: (value) => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.transparent,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          itemBuilder: (context, element) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(149, 34, 42, 0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    blurRadius: 4,
                    offset: Offset(4, 8),
                  ),
                ],
              ),
              child: ExpansionTile(
                childrenPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                expandedCrossAxisAlignment: CrossAxisAlignment.end,
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Text(
                  element.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Location: " + element.location,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      //   child: Text(
                      //     // resourceInformation[index].details,
                      //     "details",
                      //     style: TextStyle(color: Colors.white, fontSize: 14),
                      //     textAlign: TextAlign.left,
                      //   ),
                      // ),
                      Divider(
                        indent: 15,
                        endIndent: 15,
                        thickness: 1,
                        color: Colors.white38,
                        height: 7,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.phone),
                                color: Colors.white,
                              ),
                              Text(
                                "Call",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.email),
                                color: Colors.white,
                              ),
                              Text(
                                "Email",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.fax),
                                color: Colors.white,
                              ),
                              Text(
                                "Fax",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

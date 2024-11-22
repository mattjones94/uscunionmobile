import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/club_model.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  var clubData = [
    ClubsDataModel(clubName: "Student Government Association" , clubDescription: """The Student Government Association (SGA) is composed of all registered undergraduate students of the University of South Carolina Union. Upon payment of semester fees, students are automatically considered members of this organization. Student Government Association officers are elected by the student body; these officers include a president, vice president, and secretary-treasurer. Together with the senators, they make up the governing council of the SGA.

The purpose of the SGA is to represent the student body both academically and socially. The SGA schedules and directs activities. Any co-curricular activity of interest to students can be organized within the framework of the SGA. You can read the SGA Constitution [pdf] for more information. """),
    ClubsDataModel(clubName: "Research Club", clubDescription: """The USC Union Research Club aspires to expose students to a variety of research experiences across a wide range of disciplines, while facilitating connections between students and faculty that may lead to new scholarly collaborations. Club activity includes the planning and execution of a number of campus events highlighting student and faculty research (e.g. lunch-and-learns and colloquiums), fundraisers to support the Club's efforts, and field trips to immerse students and faculty with research even further. Additionally, students have the opportunity to receive funding to support their scholarly work and their dissemination of that work at professional meetings and conferences. Finally, students in the Club also have the opportunity to earn Research Club Cords as a reflection of their engagement with research and with the Club's efforts toward promoting that type of activity on campus. For more information about the club, feel free to contact Dr. Randy Lowell, and follow the Club on Instagram @USCU.Research.

Graduates: Please fill out the application for Research Club Graduation Cords and return it to Dr. Randy Lowell."""),
    ClubsDataModel(clubName: "Rotaract Club", clubDescription: """Rotaract is for students in college that want to get involved in their community and campus while building leadership and professional skills. Rotaract is a college-level Rotary Club and is a Rotary-sponsored organization. This chartered club will be a member of Rotary International. For more information, please contact Annie Smith."""),
    ClubsDataModel(clubName: "African American Association", clubDescription: """The MWOM/AAA (Men and Women on a Mission and African American Association) are organizations that try to empower all students, and teach leadership skills wherever possible, with a special focus on minority and women."""),
    ClubsDataModel(clubName: "Art Club", clubDescription: """The USC Union art club's mission is to use art to bring more vibrancy and culture to the campus and the community through creative actives and projects. Our goal is to create events and opportunities to that highlight the creative thought process in many forms.  We welcome anyone interested in art, regardless of ability to create! We want people to come and grow with us in their understanding and ability. Be sure to check out our website to view student artwork! For more information, please contact Jennifer Emswiler."""),
    ClubsDataModel(clubName: "Garden and Botany Club", clubDescription: """The Sustainable Garden and Botany Club is an organization of students, staff, and faculty dedicated to building and maintaining a garden on the USC Union campus emphasizing sustainability and pollinator/wildlife habitats. Features of the garden will include locally grown produce, native plants, composting, drip irrigation systems, plant boxes, bird and bee houses. The garden will be used for recreation, education, a natural meeting place, photo opportunities, and will help beautify the campus. The area behind the Founder’s House is currently the planned site, and construction will start mid-April 2019. The Club also plans to hold fundraisers and invite speakers to discuss gardening and foraging. The Club has a Facebook Group: USC Union’s Sustainable Garden and Botany Club."""),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.uscuBurgendy,
        title: Text(
          "Clubs",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            indent: 3,
            endIndent: 3,
            thickness: 2,
          ),
          itemCount: clubData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                clubData[index].clubName,
              ),
              trailing: Icon(Icons.info),
              leading: Icon(Icons.list),
              onTap: () {
                showModalBottomSheet(
                  context: context, 
                  builder: (context) {
                    return Column(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppTheme.colors.uscuBurgendy
                          ),
                          child: Text(
                            "Club Details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),

                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              
                              clubData[index].clubDescription,
                              textAlign: TextAlign.center,
                              ),
                          ),
                        ),
                      ],
                    );
                  }
                );
              },
            );
          },
        ),
      ),
    );
  }
}

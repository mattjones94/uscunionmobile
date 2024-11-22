import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/faculty_model.dart';
import 'package:flutter/material.dart';
import 'package:uscunionmobile/pages/faculty_detail_page.dart';

class FacultyListItem extends StatelessWidget {
  final Faculty facultyMember;
  const FacultyListItem({
    Key? key,
    required this.facultyMember,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (ListTile(
      leading: Image(
        image: AssetImage('assets/images/default_person2-removebg.png'),
        height: 30,
      ),
      tileColor: Colors.transparent,
      textColor: Colors.white,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FacultyPage(
              facultyMember: facultyMember,
            ),
          ),
        );
      },
      visualDensity: const VisualDensity(vertical: -4),
      title: Text(
        "${facultyMember.lastname}, ${facultyMember.firstname}",
        style: (TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      subtitle: Text(
        "${facultyMember.title}",
        style: TextStyle(fontSize: 10),
      ),
    ));
  }
}

class DifferentTile extends StatelessWidget {
  final String characterChange;
  const DifferentTile({
    Key? key,
    required this.characterChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      visualDensity: VisualDensity(vertical: -4),
      title: Text(
        characterChange,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
    );
  }
}

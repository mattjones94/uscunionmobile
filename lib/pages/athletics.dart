import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/pages/athletics_volleyball.dart';
import 'package:uscunionmobile/pages/athletics_web.dart';
import 'package:uscunionmobile/pages/athletics_baseball.dart';
import 'package:uscunionmobile/pages/athletics_softball.dart';
import 'package:uscunionmobile/pages/athletics_soccer.dart';

class AthleticsChoicePage extends StatefulWidget {
  const AthleticsChoicePage({Key? key}) : super(key: key);

  @override
  State<AthleticsChoicePage> createState() => _AthleticsChoicePageState();
}

class AthleticsDisplay {
  final String title;
  final IconData icon;

  AthleticsDisplay({required this.title, required this.icon});
}

class _AthleticsChoicePageState extends State<AthleticsChoicePage> {
  final List<AthleticsDisplay> athleticsOptions = [
    AthleticsDisplay(title: "Baseball", icon: Icons.sports_baseball),
    AthleticsDisplay(title: "Soccer", icon: Icons.sports_soccer),
    AthleticsDisplay(title: "Softball", icon: Icons.sports_baseball),
    AthleticsDisplay(title: "Volleyball", icon: Icons.sports_volleyball),
  ];

  final List choosingPage = [
    ['Baseball', BaseballPlayers()],
    ['Soccer', SoccerPlayers()],
    ['Softball', SoftballPlayers()],
    ['Volleyball', VolleyballPlayers()],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Banner with SliverAppBar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.grey.shade200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Athletics",
                style: TextStyle(
                  color: AppTheme.colors.uscuBurgendy,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Image.asset(
                'assets/images/athleticbanner.png', // Replace with the actual banner image
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Choose a Sport Section
          // Choose a Sport Section
SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose a Sport",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150, // Increased height for better visibility
          child: PageView.builder(
            itemCount: athleticsOptions.length,
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (context, index) {
              final option = athleticsOptions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add padding between cards
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => choosingPage[index][1],
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0), // Add padding inside the card
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(option.icon, size: 50, color: AppTheme.colors.uscuBurgendy),
                          const SizedBox(height: 10),
                          Text(
                            option.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  ),
),


          // Athletics Contact Information Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Athletics Contacts",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                _buildContactCard(
                    name: "Athletics Office",
                    title: 'Main Office',
                    phone: "(803) 999-8888",
                    email: "athletics@uscunion.edu", 
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    name: "Zach Simmons",
                    title: 'Athletics Director',
                    phone: "(864) 762-0039",
                    email: "simmonzb@mailbox.sc.edu",
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    name: "Cameron Jackson",
                    title: 'Asst. AD',
                    phone: "(803) 508-0062",
                    email: "cej16@email.sc.edu",
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // Support Athletics Section
SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Support Bantam Athletics",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Help support Bantam Athletics by sponsoring a team or attending events. "
          "Contact the Athletics Office for more details.",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              // Replace with the actual support page URL or functionality
              // Example: Launching a URL
              // launchUrlString("https://example.com");
            },
            child: Text(
              "Become a Sponsor",
              style: TextStyle(
                color: AppTheme.colors.uscuBurgendy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

          // CTA Button for Athletics Website
          SliverToBoxAdapter(
            child: Column(
              children: [ Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AthleticsWeb()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.colors.uscuBurgendy,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Visit Athletics Website",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({required String name, required String title, required String phone, required String email}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                // fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.red.shade900),
                const SizedBox(width: 8),
                Text(phone, style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.email, color: Colors.red.shade700),
                const SizedBox(width: 8),
                Text(email, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

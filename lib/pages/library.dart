import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final String libraryPhoneNumber = "(864) 427-7140";
  final String libraryEmail = "info@unionlibrary.org";
  final String libraryWebsite = "https://www.unionlibrary.org/";
  final String iCarolinaWebsite = "https://sc.edu/about/system_and_campuses/union/experience/library/index.php";

  final List<Map<String, String>> libraryCards = [
    {
      "title": "Library Hours",
      "description": """
Operating Hours:
Monday - Thursday: 8:30 AM - 6:00 PM
Friday - Saturday: 9:00 AM - 3:00 PM
Sunday: Closed
""",
    },
    {
      "title": "iCarolina Lab",
      "description":
          "Explore cutting-edge Apple-powered resources including iMacs and iPads available for free to the community.",
      "buttonText": "Visit iCarolina Website",
      "buttonUrl": "https://sc.edu/about/system_and_campuses/union/experience/library/index.php",
    },
    {
      "title": "Community Partnerships",
      "description":
          "Our library houses various nonprofits such as SC Works and Children's Advocacy Center, serving the community with valuable resources.",
    },
    {
      "title": "Renovation Project",
      "description":
          "With a 2.8 million dollar renovation, the library has been transformed into a modern facility fostering education and collaboration.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible SliverAppBar with an Image
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            floating: false,
            backgroundColor: Colors.red.shade900,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Carnegie Library",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              background: Image.asset(
                "assets/images/library.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Page Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Library Feature Cards
                  ...libraryCards.map((card) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card["title"]!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                card["description"]!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              if (card.containsKey("buttonText"))
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      launchUrlString(card["buttonUrl"]!);
                                    },
                                    child: Text(card["buttonText"]!,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                        )),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  // Contact Card
                  const SizedBox(height: 20),
                  _buildContactCard(
                    name: "Union County Carnegie Library",
                    phone: libraryPhoneNumber,
                    email: libraryEmail,
                    webAddress: libraryWebsite,
                  ),
                SizedBox(height: 30,)
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required String name,
    String? phone,
    String? email,
    String? webAddress,
  }) {
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

            // Phone
            if (phone != null)
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.red.shade900),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => launchUrlString("tel:$phone"),
                    child: Text(
                      phone,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),

            // Email
            if (email != null)
              Row(
                children: [
                  Icon(Icons.email, color: Colors.red.shade900),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => launchUrlString("mailto:$email"),
                    child: Text(
                      email,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),

            // Web Address
            if (webAddress != null)
              Row(
                children: [
                  Icon(Icons.open_in_browser, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => launchUrlString(webAddress),
                    child: const Text(
                      "Visit Website",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

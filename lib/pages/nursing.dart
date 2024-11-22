import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NursingProgram extends StatefulWidget {
  const NursingProgram({Key? key}) : super(key: key);

  @override
  State<NursingProgram> createState() => _NursingProgramState();
}

class _NursingProgramState extends State<NursingProgram> {
  final String contactPhone = "(803) 123-4567";
  final String contactEmail = "nursing@sc.edu";
  final String programUrl =
      "https://sc.edu/about/system_and_campuses/union/study/nursing.php";

  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<Map<String, String>> contactData = [
    {
      "name": "General Inquiries",
      "phone": "(803) 123-4567",
      "email": "nursing@sc.edu",
      "webAddress": "https://sc.edu/about/system_and_campuses/union/study/nursing.php",
    },
    {
      "name": "Program Advisor",
      "phone": "(803) 765-9876",
      "email": "advisor@sc.edu",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  void _callPhone(String phone) {
    launchUrlString("tel:$phone");
  }

  void _sendEmail(String email) {
    launchUrlString("mailto:$email");
  }

  void _openUrl(String url) {
    launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible SliverAppBar with Header Image
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: Colors.red.shade900,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Nursing Program",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              background: Image.asset(
                "assets/images/nursegroupheader.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Page Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Program Overview Section
                  _buildSectionHeader("Program Overview"),
                  _buildFeatureCard(
                    icon: Icons.school,
                    title: "Accredited Nursing Program",
                    description:
                        "Our BSN program is approved by the SC State Board of Nursing and accredited by CCNE.",
                  ),
                  _buildFeatureCard(
                    icon: Icons.timeline,
                    title: "Curriculum Framework",
                    description:
                        "A progressive curriculum with core concepts of care, communication, and role development.",
                  ),
                  _buildFeatureCard(
                    icon: Icons.local_hospital,
                    title: "Diverse Clinical Settings",
                    description:
                        "Gain hands-on experience in hospitals, clinics, and community settings.",
                  ),
                  const SizedBox(height: 20),

                  // Interactive Contact Cards
                  _buildSectionHeader("Contact Information"),
                  SizedBox(
                    height: 230,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: contactData.length,
                      itemBuilder: (context, index) {
                        final contact = contactData[index];
                        return _buildContactCard(
                          name: contact["name"]!,
                          phone: contact["phone"],
                          email: contact["email"],
                          webAddress: contact["webAddress"],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        contactData.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.red.shade900
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Admissions Section
                  _buildSectionHeader("Admission Requirements"),
                  _buildChecklistCard([
                    "Complete prerequisites.",
                    "Submit your application.",
                    "Join a prestigious program.",
                  ]),

                  const SizedBox(height: 20),

                  // Program Website Link
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _openUrl(programUrl),
                      icon: const Icon(Icons.open_in_browser, color: Colors.white,),
                      label: const Text("Visit Program Website", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        
                        backgroundColor: Colors.red.shade900,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.red.shade900,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
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
            if (phone != null)
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.red.shade900),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _callPhone(phone),
                    child: Text(phone, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            if (email != null)
              Row(
                children: [
                  Icon(Icons.email, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _sendEmail(email),
                    child: Text(email, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            if (webAddress != null)
              Row(
                children: [
                  Icon(Icons.open_in_browser, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _openUrl(webAddress),
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

  Widget _buildChecklistCard(List<String> items) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Checklist for Applicants",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            for (var item in items)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "• ",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
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

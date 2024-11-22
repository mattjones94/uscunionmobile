import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MentalHealth extends StatefulWidget {
  const MentalHealth({Key? key}) : super(key: key);

  @override
  State<MentalHealth> createState() => _MentalHealthState();
}

class _MentalHealthState extends State<MentalHealth> {
  final String supportPhoneNumber = "(800) 633-3353";
  final String myGroupUrl = "https://www.mygroup.com/";
  final String dylanPhoneNumber = "(803)999-6778";
  final String dylanEmail = "dw68@email.sc.edu";
  final String uWillPhoneNumber = "(833) 646-1526";
  final String uWillUrl = "https://app.uwill.com/register";

  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactCards = [
      _buildContactCard(
        name: "MyGroup Support",
        phone: supportPhoneNumber,
        webAddress: myGroupUrl,
      ),
      _buildContactCard(
        name: "Dylan Wong",
        phone: dylanPhoneNumber,
        email: dylanEmail,
      ),
      _buildContactCard(
        name: "UWill Support",
        phone: uWillPhoneNumber,
        webAddress: uWillUrl,
      ),
    ];

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
              title: Text(
                "Mental Health Services",
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              background: Image.asset(
                "assets/images/mentalhealth_header.png",
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
                  // Feature Cards Section
                  _buildFeatureCard(
                    icon: Icons.support_agent,
                    title: "24/7 Confidential Support",
                    description:
                        "Access help anytime for personal or work-related challenges.",
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureCard(
                    icon: Icons.devices,
                    title: "Easy-to-Use Online Platform",
                    description:
                        "Connect with licensed professionals through a secure platform.",
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureCard(
                    icon: Icons.group,
                    title: "Support for Families",
                    description:
                        "Services are available to you and your household members.",
                  ),
                  const SizedBox(height: 20),

                  // Contact Cards Section
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: contactCards.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: contactCards[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contactCards.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.red.shade900
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
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
                  Icon(Icons.email, color: Colors.red.shade700),
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

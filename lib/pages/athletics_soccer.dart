import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/athletics_soccer_model.dart';
import 'package:uscunionmobile/network_services/athletics_soccer_network.dart';

class SoccerPlayers extends StatefulWidget {
  const SoccerPlayers({Key? key}) : super(key: key);

  @override
  State<SoccerPlayers> createState() => _SoccerPlayersState();
}

class _SoccerPlayersState extends State<SoccerPlayers> {
  List<SoccerDataModel>? soccerData;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchSoccerData();
  }

  Future<void> fetchSoccerData() async {
    soccerData = await SoccerRemoteService().getSoccerPost();
    if (mounted) {
      setState(() {
        isLoaded = soccerData != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.uscuBurgendy,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.uscuBurgendy,
        title: const Text(
          "Soccer Players",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoaded ? buildGridView() : buildLoadingIndicator(),
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: soccerData?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the number of columns for responsiveness
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Card aspect ratio
        ),
        itemBuilder: (context, index) {
          final player = soccerData![index];
          return GestureDetector(
            onTap: () {
              // Navigate to detailed page or perform an action
            },
            child: Card(
              color: AppTheme.colors.lightBurgendy,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.network(
                      "https://uscmobileapps.com/uscumobile/uscusports/uscusoccer/uscusoccerimages/${player.soccer_image}",
                      height: 150,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/bantum_default.png',
                          height: 150,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${player.soccer_first_name} ${player.soccer_last_name}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        if (player.soccer_position != null)
                          Text(
                            "Position: ${player.soccer_position}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        // if (player.soccer_jersey_number != null)
                        //   Text(
                        //     "Jersey: ${player.soccer_jersey_number}",
                        //     style: const TextStyle(
                        //       color: Colors.white70,
                        //       fontSize: 14,
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    soccerData?.clear();
    super.dispose();
  }
}

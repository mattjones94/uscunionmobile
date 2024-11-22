import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/athletics_softball_model.dart';
import 'package:uscunionmobile/network_services/athletics_softball_network.dart';

class SoftballPlayers extends StatefulWidget {
  const SoftballPlayers({Key? key}) : super(key: key);

  @override
  State<SoftballPlayers> createState() => _SoftballPlayersState();
}

class _SoftballPlayersState extends State<SoftballPlayers> {
  List<SoftballDataModel>? softballData;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchSoftballData();
  }

  Future<void> fetchSoftballData() async {
    softballData = await SoftballRemoteService().getSoftballPost();
    if (mounted) {
      setState(() {
        isLoaded = softballData != null;
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
          "Softball Players",
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
        itemCount: softballData?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust for responsiveness
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Card aspect ratio
        ),
        itemBuilder: (context, index) {
          final player = softballData![index];
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
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.network(
                      "https://uscmobileapps.com/uscumobile/uscusports/uscusoftball/uscusoftballimages/${player.soft_image}",
                      height: 150,
                      width: double.infinity,
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
                      children: [
                        Text(
                          "${player.soft_first_name} ${player.soft_last_name}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        if (player.soft_position != null)
                          Text(
                            "Position: ${player.soft_position}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        // if (player.soft_jersey_number != null)
                        //   Text(
                        //     "Jersey: ${player.soft_jersey_number}",
                        //     style: const TextStyle(
                        //       color: Colors.white70,
                        //       fontSize: 14,
                        //     ),
                        //     textAlign: TextAlign.center,
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
    softballData?.clear();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/athletics_baseball_model.dart';
import 'package:uscunionmobile/network_services/athletics_baseball_network.dart';

class BaseballPlayers extends StatefulWidget {
  const BaseballPlayers({Key? key}) : super(key: key);

  @override
  State<BaseballPlayers> createState() => _BaseballPlayersState();
}

class _BaseballPlayersState extends State<BaseballPlayers> {
  List<BaseballDataModel>? baseballData;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchBaseballData();
  }

  Future<void> fetchBaseballData() async {
    baseballData = await BaseballRemoteService().getBaseballPost();
    if (mounted) {
      setState(() {
        isLoaded = baseballData != null;
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
          "Baseball Players",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoaded ? buildPlayerGrid() : buildLoadingIndicator(),
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildPlayerGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust columns for better spacing
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Adjust card aspect ratio
        ),
        itemCount: baseballData?.length ?? 0,
        itemBuilder: (context, index) {
          final player = baseballData![index];
          return GestureDetector(
            onTap: () {
              // Add navigation or detailed page logic here if required
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              color: AppTheme.colors.lightBurgendy,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.network(
                      "https://uscmobileapps.com/uscumobile/uscusports/uscubaseball/uscubaseballimages/${player.bballimage}",
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
                          "${player.bballfirstname} ${player.bballlastname}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        if (player.bballposition != null)
                          Text(
                            "Position: ${player.bballposition}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        // if (player.bballjerseynumber != null)
                        //   Text(
                        //     "Jersey: ${player.bballjerseynumber}",
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
    baseballData?.clear();
    super.dispose();
  }
}

import 'package:apex_mobile/views/apex_news.dart';
import 'package:apex_mobile/views/crafter_rotation.dart';
import 'package:apex_mobile/views/map_rotation.dart';
import 'package:apex_mobile/views/player_stats.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apex Legends Mobile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            //MAP ROTATION
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapRotationPage()),
                );
              },
              child: const Text('Map Rotation'),
            ),
            //CRAFTER ROTATION
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CrafterRotationPage()),
                );
              },
              child: const Text('Crafter Rotation'),
            ),
            //APEX NEWS
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApexNewsPage()),
                );
              },
              child: const Text('NEWS'),
            ),
            //PLAYER STATS
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayerStatsPage()),
                );
              },
              child: const Text('PLAYER STATS'),
            ),
          ],
        ),
      ),
    );
  }
}
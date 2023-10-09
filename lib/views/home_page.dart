import 'package:apex_mobile/views/apex_news.dart';
import 'package:apex_mobile/views/crafter_rotation.dart';
import 'package:apex_mobile/views/map_rotation.dart';
import 'package:apex_mobile/views/player_stats.dart';
import 'package:apex_mobile/views/sub_screen/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apex Legends Mobile'),
      ),
      body: Container(
        color: const Color(0xFF17194C),
        child: GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapRotationPage()),
                );
              },
              child: const Text('Map Rotation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CrafterRotationPage()),
                );
              },
              child: const Text('Crafter Rotation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApexNewsPage()),
                );
              },
              child: const Text('NEWS'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayerStatsPage()),
                );
              },
              child: const Text('Player Stats'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayerStatsPage()),
                );
              },
              child: const Text('To reach Predator'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Store Items'),
            ),
          ],
        ),
      ),
    );
  }
}
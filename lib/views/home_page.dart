import 'package:apex_mobile/views/map_rotation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Apex Legends Mobile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapRotationPage()),
            );
          },
          child: const Text('Open Map Rotation'),
        ),
      ),
    );
  }
}
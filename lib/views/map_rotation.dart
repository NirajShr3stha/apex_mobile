import 'package:apex_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MapRotationPage extends StatefulWidget {
  const MapRotationPage({Key? key}) : super(key: key);

  @override
  _MapRotationPageState createState() => _MapRotationPageState();
}

class _MapRotationPageState extends State<MapRotationPage> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? mapRotationData;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    fetchMapRotationData();
    // Start the timer to update the remaining time every second
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          // Check if remaining time is 00:00 and fetch new data
          if (mapRotationData != null &&
              (mapRotationData!['battle_royale']['current']['remainingSecs'] == 0 ||
                  mapRotationData!['arenas']['current']['remainingSecs'] == 0 ||
                  mapRotationData!['ltm']['current']['remainingSecs'] == 0)) {
            fetchMapRotationData();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Rotation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 70), // Add padding to the bottom
        child: Center(
          child: mapRotationData != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Current Map (Battle Royale): ${mapRotationData!['battle_royale']['current']['map']}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.network(
                      mapRotationData!['battle_royale']['current']['asset'].replaceAll('\\', ''),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Remaining Time: ${mapRotationData!['battle_royale']['current']['remainingTimer']}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Next Map (Battle Royale): ${mapRotationData!['battle_royale']['next']['map']}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.network(
                      mapRotationData!['battle_royale']['next']['asset'].replaceAll('\\', ''),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 32),
                    // Add similar code for Arenas, Ranked, ArenasRanked, and LTM
                    // You can use the existing code as a reference and modify it accordingly.
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> fetchMapRotationData() async {
    try {
      final data = await _apiService.getMapRotationData();
      setState(() {
        mapRotationData = data;
      });
    } catch (e) {
      print('Error fetching map rotation data: $e');
    }
  }
}


//THIS WORKS BUT TIMER ISNT IMPLEMENTED
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// class ApiService {
//   Future<Map<String, dynamic>> getMapRotationData() async {
//     const url =
//         'https://api.mozambiquehe.re/maprotation/?auth=a2bb8c12bd1d0d81a84c6e0ddc401369&version=2';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       return jsonData;
//     } else {
//       throw Exception('Failed to fetch map rotation data');
//     }
//   }
// }

// class MapRotationPage extends StatefulWidget {
//   const MapRotationPage({Key? key}) : super(key: key);

//   @override
//   _MapRotationPageState createState() => _MapRotationPageState();
// }

// class _MapRotationPageState extends State<MapRotationPage> {
//   final ApiService _apiService = ApiService();
//   Map<String, dynamic>? mapRotationData;
//   late Timer timer;

//   @override
//   void initState() {
//     super.initState();
//     fetchMapRotationData();
//     // Start the timer to update the remaining time every second
//     timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
//       if (mounted) {
//         setState(() {
//           // Check if remaining time is 00:00 and fetch new data
//           if (mapRotationData != null &&
//               (mapRotationData!['battle_royale']['current']['remainingSecs'] == 0 ||
//                   mapRotationData!['arenas']['current']['remainingSecs'] == 0 ||
//                   mapRotationData!['ltm']['current']['remainingSecs'] == 0)) {
//             fetchMapRotationData();
//           }
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // Cancel the timer when the widget is disposed
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Rotation'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(bottom: 70), // Add padding to the bottom
//         child: Center(
//           child: mapRotationData != null
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [

//                   Text(
//                     'Current Map (Battle Royale): ${mapRotationData!['battle_royale']['current']['map']}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Image.network(
//                     mapRotationData!['battle_royale']['current']['asset'],
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 32),
//                   Text(
//                     'Current Map (Arenas): ${mapRotationData!['arenas']['current']['map']}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Image.network(
//                     mapRotationData!['arenas']['current']['asset'],
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 32),
//                   Text(
//                     'Current Map (LTM): ${mapRotationData!['ltm']['current']['map']}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Image.network(
//                     mapRotationData!['ltm']['current']['asset'],
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ],
//               )
//             : const CircularProgressIndicator(),
//     ),
//       ),
//     );
//   }
//   Future<void> fetchMapRotationData() async {
//     try {
//       final data = await _apiService.getMapRotationData();
//       setState(() {
//         mapRotationData = data;
//       });
//     } catch (e) {
//       print('Error fetching map rotation data: $e');
//     }
//   }


//   String getRemainingTime(int endTime) {
//     final DateTime now = DateTime.now();
//     final DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endTime * 1000);
//     final Duration duration = endDateTime.difference(now);
//     final String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
//     final String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// class ApiService {
//   Future<Map<String, dynamic>> getMapRotationData() async {
//     const url =
//         'https://api.mozambiquehe.re/maprotation/?auth=a2bb8c12bd1d0d81a84c6e0ddc401369&version=2';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       return jsonData;
//     } else {
//       throw Exception('Failed to fetch map rotation data');
//     }
//   }
// }

// class MapRotationPage extends StatefulWidget {
//   const MapRotationPage({Key? key}) : super(key: key);

//   @override
//   _MapRotationPageState createState() => _MapRotationPageState();
// }

// class _MapRotationPageState extends State<MapRotationPage> {
//   final ApiService _apiService = ApiService();
//   Map<String, dynamic>? mapRotationData;
//   late Timer timer;

//   @override
//   void initState() {
//     super.initState();
//     fetchMapRotationData();
//     // Start the timer to update the remaining time every second
//     timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // Cancel the timer when the widget is disposed
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Rotation'),
//       ),
//       body: Center(
//         child: mapRotationData != null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Current Map: ${mapRotationData!['battle_royale']['current']['map']}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Remaining Time: ${getRemainingTime(mapRotationData!['battle_royale']['current']['end'])}',
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 16),
//                   Image.network(
//                     mapRotationData!['battle_royale']['current']['asset'],
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 26),
//                   Text(
//                     'Next Map: ${mapRotationData!['battle_royale']['next']['map']}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Image.network(
//                     mapRotationData!['battle_royale']['next']['asset'],
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
                  
//                 ],
//               )
//             : const CircularProgressIndicator(),
//       ),
//     );
//   }

//   Future<void> fetchMapRotationData() async {
//     try {
//       final data = await _apiService.getMapRotationData();
//       setState(() {
//         mapRotationData = data;
//       });
//     } catch (e) {
//       print('Error fetching map rotation data: $e');
//     }
//   }

//   String getRemainingTime(int endTime) {
//     final DateTime now = DateTime.now();
//     final DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endTime * 1000);
//     final Duration duration = endDateTime.difference(now);
//     final String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
//     final String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }
// }


import 'package:apex_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

class MapRotationPage extends StatefulWidget {
  const MapRotationPage({Key? key}) : super(key: key);

  @override
  _MapRotationPageState createState() => _MapRotationPageState();
}

class _MapRotationPageState extends State<MapRotationPage> {
  final MapApiService _apiService = MapApiService();
  Map<String, dynamic>? mapRotationData;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    fetchMapRotationData();
    // Start the timer to update the remaining time every second
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {});
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
      body: Center(
        child: mapRotationData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Column(
                        children: [
                          //PUBS CURRENT MAP
                          Text(
                            'Current PUBs Map: ${mapRotationData!['battle_royale']['current']['map']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Remaining Time: ${getRemainingTime(mapRotationData!['battle_royale']['current']['end'])}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Image.network(
                            mapRotationData!['battle_royale']['current']
                                ['asset'],
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          //PUBS NEXT MAP
                          const SizedBox(height: 10),
                          Text(
                            'Next Map: ${mapRotationData!['battle_royale']['next']['map']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),
                          Image.network(
                            mapRotationData!['battle_royale']['next']['asset'],
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),

                          const SizedBox(height: 26),
                          //add horitonal line
                          const Divider(
                            height: 1,
                            thickness: 4,
                            color: Colors.black,
                          ),

                          //CURRENT RANKED MAP
                          const SizedBox(height: 26),
                          Text(
                            'Current Ranked Map: ${mapRotationData!['ranked']['current']['map']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Remaining Time: ${getRemainingTime(mapRotationData!['ranked']['current']['end'])}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Image.network(
                            mapRotationData!['ranked']['current']['asset'],
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),

                          //NEXT RANKED MAP
                          const SizedBox(height: 26),
                          Text(
                            'Next Map: ${mapRotationData!['ranked']['next']['map']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Image.network(
                            mapRotationData!['ranked']['next']['asset'],
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),

                          const SizedBox(height: 26),
                          //add horitonal line
                          const Divider(
                            height: 1,
                            thickness: 4,
                            color: Colors.black,
                          ),

                          //CURRENT MIX TAPE MAP
                          const SizedBox(height: 26),
                          Text(
                            'Current Mixtape Mode: ${mapRotationData!['ltm']['current']['eventName']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Remaining Time: ${getRemainingTime(mapRotationData!['ltm']['current']['end'])}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Image.network(
                            mapRotationData!['ltm']['current']['asset']
                                .replaceAll('\\', ''),
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),

                          //NEXT MIX TAPE MAP
                          const SizedBox(height: 26),
                          Text(
                            'Next Mixtape Mode: ${mapRotationData!['ltm']['next']['eventName']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Image.network(
                            mapRotationData!['ltm']['next']['asset']
                                .replaceAll('\\', ''),
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
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

  String getRemainingTime(int endTime) {
    final DateTime now = DateTime.now();
    final DateTime endDateTime =
        DateTime.fromMillisecondsSinceEpoch(endTime * 1000);
    final Duration duration = endDateTime.difference(now);

    if (duration.isNegative || duration.inSeconds <= 0) {
      // Countdown reached or passed zero, trigger API refresh here
      fetchMapRotationData();
      return '00:00:00'; // Display 00:00:00 when refreshing data
    }

    final String hours = (duration.inHours % 24).toString().padLeft(2, '0');
    final String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }
}
//was working dk what happened 

// import 'package:apex_mobile/services/api_service.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// class MapRotationPage extends StatefulWidget {
//   const MapRotationPage({Key? key}) : super(key: key);

//   @override
//   _MapRotationPageState createState() => _MapRotationPageState();
// }

// class _MapRotationPageState extends State<MapRotationPage> {
//   final MapApiService _apiService = MapApiService();
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

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Map Rotation'),
//     ),
//     body: Center(
//       child: mapRotationData != null
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                     child: Column(
//                       children: [
//                         //PUBS CURRENT MAP
//                         Text(
//                           'Current PUBs Map: ${mapRotationData!['battle_royale']['current']['map']}',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'Remaining Time: ${getRemainingTime(mapRotationData!['battle_royale']['current']['end'])}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 16),
//                         Image.network(
//                           mapRotationData!['battle_royale']['current']['asset'],
//                           width: double.infinity,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//                         //PUBS NEXT MAP
//                         const SizedBox(height: 10),
//                         Text(
//                           'Next Map: ${mapRotationData!['battle_royale']['next']['map']}',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
                        
//                         const SizedBox(height: 12),
//                         Image.network(
//                           mapRotationData!['battle_royale']['next']['asset'],
//                           width: double.infinity,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
                        
//                         const SizedBox(height: 26),
//                         //add horitonal line
//                          const Divider(
//                           height: 1,
//                           thickness: 4,
//                           color: Colors.black,
//                         ),

//                         //CURRENT RANKED MAP
//                         const SizedBox(height: 26),
//                         Text(
//                           'Current Ranked Map: ${mapRotationData!['ranked']['current']['map']}',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'Remaining Time: ${getRemainingTime(mapRotationData!['ranked']['current']['end'])}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 16),
//                         Image.network(
//                           mapRotationData!['ranked']['current']['asset'],
//                           width: double.infinity,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),

//                         //NEXT RANKED MAP
//                         const SizedBox(height: 26),
//                         Text(
//                           'Next Map: ${mapRotationData!['ranked']['next']['map']}',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Image.network(
//                           mapRotationData!['ranked']['next']['asset'],
//                           width: double.infinity,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),

//                          const SizedBox(height: 26),
//                         //add horitonal line
//                          const Divider(
//                           height: 1,
//                           thickness: 4,
//                           color: Colors.black,
//                         ),

//                          //CURRENT MIX TAPE MAP
//                         const SizedBox(height: 26),
//                         Text(
//                           'Current Mixtape Mode: ${mapRotationData!['ltm']['current']['eventName']}',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'Remaining Time: ${getRemainingTime(mapRotationData!['ltm']['current']['end'])}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 16),
//                         Image.network(
//                           mapRotationData!['ltm']['next']['asset'],
//                           width: double.infinity,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),

//                         //NEXT MIX TAPE MAP
//                         const SizedBox(height: 26),
//                         Text(
//                           'Next Mixtape Mode: ${mapRotationData!['ltm']['next']['eventName']}',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Image.network(
//                           mapRotationData!['ltm']['next']['asset'],
//                           width: double.infinity,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : const CircularProgressIndicator(),
//     ),
//   );
// }

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

// String getRemainingTime(int endTime) {
//   final DateTime now = DateTime.now();
//   final DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endTime * 1000);
//   final Duration duration = endDateTime.difference(now);

//   if (duration.isNegative || duration.inSeconds <= 0) {
//     // Countdown reached or passed zero, trigger API refresh here
//     fetchMapRotationData();
//     return '00:00:00'; // Display 00:00:00 when refreshing data
//   }

//   final String hours = (duration.inHours % 24).toString().padLeft(2, '0');
//   final String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
//   final String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

//   return '$hours:$minutes:$seconds';
// }
// }
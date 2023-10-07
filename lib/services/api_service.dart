import 'package:http/http.dart' as http;
import 'dart:convert';

//FOR SHOWING CURRENT MAP ROTATION
Future<Map<String, dynamic>> getMapRotationData() async {
  const url = 'https://api.mozambiquehe.re/maprotation/?auth=a2bb8c12bd1d0d81a84c6e0ddc401369&version=2';
  final response = await http.get(Uri.parse(url));
  
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return jsonData;
  } else {
    throw Exception('Failed to fetch map rotation data');
  }
}
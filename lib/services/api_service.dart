import 'package:http/http.dart' as http;
import 'dart:convert';

//MAP ROTATION API
class ApiService {
  static const apiKey = 'a2bb8c12bd1d0d81a84c6e0ddc401369';
  static const version = '2'; //1 for battle royale pubs only, 2 for all modes.

  Future<Map<String, dynamic>> getMapRotationData() async {
    const url = 'https://api.mozambiquehe.re/maprotation/?auth=$apiKey&version=$version';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch map rotation data');
    }
  }
}
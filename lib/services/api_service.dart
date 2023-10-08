import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'a2bb8c12bd1d0d81a84c6e0ddc401369';

//MAP ROTATION API
class MapApiService {
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

//CRAFTER ROTATION API
class CrafterRotationApiService {
  Future<List<Map<String, dynamic>>> getCrafterRotationData() async {
    const url = 'https://api.mozambiquehe.re/crafting?auth=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to fetch crafter rotation data');
    }
  }
}

//NEWS API
class NewsApiService {
  Future<List<Map<String, dynamic>>> getCrafterRotationData() async {
    const url = 'https://api.mozambiquehe.re/news?auth=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to fetch  news data');
    }
  }
}

//PLAYER STATS API
class PlayerStatsApiService {
  Future<Map<String, dynamic>> getPlayerStats(String username) async {
    final url = 'https://api.mozambiquehe.re/bridge?auth=$apiKey&player=$username&platform=PC';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch player stats data');
    }
  }
}

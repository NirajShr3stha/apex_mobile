import 'package:apex_mobile/services/api_service.dart';
import 'package:flutter/material.dart';

class PlayerStatsPage extends StatefulWidget {
  @override
  _PlayerStatsPageState createState() => _PlayerStatsPageState();
}

class _PlayerStatsPageState extends State<PlayerStatsPage> {
  final TextEditingController _usernameController = TextEditingController();
  Map<String, dynamic>? _playerData;
  final PlayerStatsApiService _apiService = PlayerStatsApiService();

  Future<void> _fetchPlayerStats(String username) async {
    try {
      final playerData = await _apiService.getPlayerStats(username);
      setState(() {
        _playerData = playerData;
      });
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Stats'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text;
                  _fetchPlayerStats(username);
                },
                child: const Text('Check Stats'),
              ),
              const SizedBox(height: 16),
              if (_playerData != null)
                Column(
                  children: [
                    //PLAYER NAME
                    Text(
                      'Player Name: ${_playerData!['global']['name']}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //EA DISABLED ACCESS TO PROFILE AVATARS
                    // const SizedBox(height: 16),
                    // Image.network(
                    //   _playerData!['global']['avatar'],
                    //   width: 100,
                    //   height: 100,
                    //   fit: BoxFit.cover,
                    // ),
                    const SizedBox(height: 16),
                    //PLATFORM
                    Text(
                      'Platform: ${_playerData!['global']['platform']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    //ACCOUNT LEVEL
                    Text(
                      'Level: ${_playerData!['global']['level']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    //RANK POINTS
                    Text(
                      'Rank Score: ${_playerData!['global']['rank']['rankScore']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    //BATTLEPASS LEVEL
                    Text(
                      'Battlepass Level: ${_playerData!['global']['battlepass']['level']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    //PRESTIGE LEVEL
                    Text(
                      'PRESTIGE LEVEL: ${_playerData!['global']['levelPrestige']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    //REALTIME STATUS
                    Text(
                      'Current Status: ${_playerData!['realtime']['currentStateAsText']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Lobby State: ${_playerData!['isInGame'] == 1 ? 'In Game' : 'Not In Game'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Last Game Legend: ${_playerData!['realtime'] ['selectedLegend']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    // Text(
                    //   'Online Status: ${_playerData!['realtime']['currentState'] == 'online' ? 'Online' : 'Offline'}',
                    //   style: const TextStyle(fontSize: 18),
                    // ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

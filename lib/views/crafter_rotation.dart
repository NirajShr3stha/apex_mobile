import 'package:apex_mobile/services/api_service.dart';
import 'package:flutter/material.dart';

class CrafterRotationPage extends StatefulWidget {
  const CrafterRotationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CrafterRotationScreenState createState() => _CrafterRotationScreenState();
}

class _CrafterRotationScreenState extends State<CrafterRotationPage> {
  final CrafterRotationApiService _apiService = CrafterRotationApiService();

  List<Map<String, dynamic>> _rotationData = [];

  @override
  void initState() {
    super.initState();
    fetchCrafterRotationData();
  }

  Future<void> fetchCrafterRotationData() async {
    try {
      final data = await _apiService.getCrafterRotationData();
      setState(() {
        _rotationData = data;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error condition
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crafter Rotation'),
      ),
      body: ListView.builder(
        itemCount: _rotationData.length,
        itemBuilder: (BuildContext context, int index) {
          final bundle = _rotationData[index];
          final bundleContent = bundle['bundleContent'];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //DAILY ROTATIONS
                ListTile(
                  title: Text('Rotation type: ${bundle['bundleType']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),),
                ),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bundleContent.length,
                  itemBuilder: (BuildContext context, int index) {
                    final content = bundleContent[index];
                    final itemType = content['itemType'];

                    return ListTile(
                      title: Text('Item: ${content['item']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Crafting Cost: ${content['cost']}'),
                          Text('Loot Name: ${itemType['name']}'),
                          Text('Rarity: ${itemType['rarity']}'),
                          //Text('Item Type Rarity Hex: ${itemType['rarityHex']}'),
                        ],
                      ),
                      leading: Image.network(itemType['asset']),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
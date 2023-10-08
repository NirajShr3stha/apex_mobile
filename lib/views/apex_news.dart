import 'package:apex_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class ApexNewsPage extends StatefulWidget {
  const ApexNewsPage({Key? key}) : super(key: key);

  @override
  _ApexNewsPageState createState() => _ApexNewsPageState();
}

class _ApexNewsPageState extends State<ApexNewsPage> {
  final NewsApiService newsApiService = NewsApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apex News'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: newsApiService.getCrafterRotationData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final newsList = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: newsList.map((news) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //LOAD IMAGE NEEDS FIXING
                        // SizedBox(
                        //   width: 100,
                        //   child: _buildNewsImage(news['img']),
                        // ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  news['short_desc'],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to fetch news data'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildNewsImage(String imageUrl) {
    final cleanedImageUrl = imageUrl.replaceAll('\\', '');
    return FutureBuilder<Uint8List>(
      future: _fetchImage(cleanedImageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          // Image fetched successfully, display it
          return Image.memory(snapshot.data!);
        } else if (snapshot.hasError) {
          // Error occurred while fetching image
          return const Icon(Icons.error);
        } else {
          // Image still loading
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<Uint8List> _fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
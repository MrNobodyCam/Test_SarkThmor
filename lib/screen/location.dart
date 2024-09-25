import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List locations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Location List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 26,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          final id = location['location_id'];
          final name = location['province'] ?? 'No name';
          return ListTile(
            leading: Text('$id'),
            title: Text(name),
          );
        }
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: fetchLocation,
        child: const Icon(Icons.download),
      ),
    );
  }


  Future<void> fetchLocation() async {
    const url = 'http://10.0.2.2:8989/api/v1/accommodations/locations/';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('API Response: $json');
        setState(() {
          locations = json['locations'] ?? [];
        });
      } else {
        print('Failed to load location: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

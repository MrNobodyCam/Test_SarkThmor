import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_example/common/api_constants.dart';
import 'package:test_example/utils/error_handling.dart';
import 'package:test_example/utils/constant.dart';
import 'package:flutter/foundation.dart'; // For compute()

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List> accommodationsFuture;

  @override
  void initState() {
    super.initState();
    accommodationsFuture = fetchAccommodations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accommodation List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 26,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: accommodationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No accommodations found'));
          } else {
            final accommodations = snapshot.data!;
            return ListView.builder(
              itemCount: accommodations.length,
              itemBuilder: (context, index) {
                final accommodation = accommodations[index];
                final id = accommodation['accommodation_id'] ?? 'N/A';
                final name = accommodation['name'] ?? 'No name';
                final pricepernight = accommodation['price_per_night'] ?? 'No name';
                return ListTile(
                  leading: Text('$id'),
                  title: Text(name),
                  subtitle: Text("\$ "+pricepernight),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            accommodationsFuture = fetchAccommodations(); // Re-fetch data
          });
        },
        child: const Icon(Icons.download),
      ),
    );
  }

  // Fetch accommodations from the API
  Future<List> fetchAccommodations() async {
    try {
      final url = Uri.parse(APIEndPoint.baseUrl +
          APIEndPoint.version +
          APIEndPoint.listAccommodation.listAccommodations);

      final response = await http.get(url);
      print('Raw Response Status: ${response.statusCode}'); // Debugging
      print('Raw Response Body: ${response.body}'); // Debugging

      return await httpErrorHandleWithResult(
        response: response,
        context: context,
      );
    } catch (e) {
      showSnackBar(context, 'Failed to fetch accommodations: $e');
      return [];
    }
  }

  Future<List> httpErrorHandleWithResult({
    required http.Response response,
    required BuildContext context,
  }) async {
    if (response.statusCode == 200) {
      return compute(parseAccommodations, response.body);
    } else {
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
      return [];
    }
  }
}

List parseAccommodations(String responseBody) {
  final Map<String, dynamic> parsed = jsonDecode(responseBody);
  if (parsed['results'] != null && parsed['results']['data'] != null) {
    return parsed['results']['data'] as List;
  } else {
    print('No data found in the response.');
    return [];
  }
}

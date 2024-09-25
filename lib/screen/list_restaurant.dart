import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // Background color matching the layout
        elevation: 0, // Remove shadow to make it flat
        leading: IconButton(
          icon: Image.asset(
            "assets/images/back.png",
            width: 30,
            height: 30,
          ),
          onPressed: () {
            // Add navigation or action
          },
        ),
        title: const Text(
          'Restaurant',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xff20B08E),
          ),
        ),
        centerTitle: true,
      ),

      // Body of the app
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            // Spacing between AppBar and search bar
            const SizedBox(height: 20),

            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Discover any places',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Image.asset('assets/images/search.png')
                ],
              ),
            ),

            const SizedBox(height: 20), // Spacing between search bar and content

            // List of images and descriptions
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 21),
                children: [
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/place.jpg', // Replace with your image
                              fit: BoxFit.cover,
                              width: 366,
                              height: 159,
                            ),
                          ),
                          const SizedBox(height: 10), // Space between image and text
                          const Text(
                            'MALIS Restaurant',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            'No. 136, Norodom Blvd, Phnom Penh',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add more restaurant entries similarly
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

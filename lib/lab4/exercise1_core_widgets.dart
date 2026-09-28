import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 – Core Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline Text
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Material Icon
            const Center(
              child: Icon(
                Icons.movie,
                size: 64,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            // Image from Internet
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                'https://images.moviesanywhere.com/e84b2c6e0de5278f8a00a8fedf73d60b/367910a3-05da-4ad5-8ef3-317708a1ca48.jpg',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Card containing ListTile
            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Movie Item'),
                subtitle: const Text(
                  'This is a sample ListTile inside a Card.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoreWidgetsDemo(),
    ),
  );
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Lab81App());
}

class Lab81App extends StatelessWidget {
  const Lab81App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 8.1 - GET Request',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const GetRequestScreen(),
    );
  }
}

class GetRequestScreen extends StatefulWidget {
  const GetRequestScreen({super.key});

  @override
  State<GetRequestScreen> createState() =>
      _GetRequestScreenState();
}

class _GetRequestScreenState extends State<GetRequestScreen> {
  bool _isLoading = false;
  String _result = 'Press the button to fetch API data.';
  String _status = '';

  Future<void> fetchPosts() async {
    setState(() {
      _isLoading = true;
      _result = '';
      _status = '';
    });

    try {
      final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts',
      );

      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 15));

      debugPrint('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Decode the JSON response.
        final List<dynamic> data =
        json.decode(response.body) as List<dynamic>;

        // Print raw JSON data in the Debug Console.
        debugPrint('API response: ${response.body}');

        setState(() {
          _status = 'Success: HTTP ${response.statusCode}';
          _result =
          'Successfully fetched ${data.length} posts!\n\n'
              'First post:\n'
              '${const JsonEncoder.withIndent('  ').convert(data.first)}';
        });
      } else {
        throw Exception(
          'Request failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('GET request error: $e');

      setState(() {
        _status = 'Request failed';
        _result = 'Unable to fetch API data.\n$e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8.1 - GET Request'),
        backgroundColor:
        Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.cloud_download_outlined,
              size: 64,
              color: Colors.indigo,
            ),
            const SizedBox(height: 12),
            const Text(
              'Simple GET Request',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'API: jsonplaceholder.typicode.com/posts',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _isLoading ? null : fetchPosts,
              icon: const Icon(Icons.download),
              label: const Text('Fetch API Data'),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (_status.isNotEmpty)
              Text(
                _status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _status.startsWith('Success')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: SelectableText(_result),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double rating = 50;
  bool isActive = false;
  String selectedGenre = 'None';
  DateTime? selectedDate;

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('Exercise 2 – Input Controls'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rating (Slider)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            Slider(
              value: rating,
              min: 0,
              max: 100,
              divisions: 100,
              label: rating.round().toString(),
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),

            Text('Current value: ${rating.round()}'),

            const SizedBox(height: 20),

            const Text(
              'Active (Switch)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            SwitchListTile(
              title: const Text('Is movie active?'),
              value: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
            ),

            const SizedBox(height: 12),

            const Text(
              'Genre (RadioListTile)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Action'),
              value: 'Action',
              groupValue: selectedGenre,
              onChanged: (value) {
                setState(() {
                  selectedGenre = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: selectedGenre,
              onChanged: (value) {
                setState(() {
                  selectedGenre = value!;
                });
              },
            ),

            Text('Selected genre: $selectedGenre'),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: selectDate,
                child: const Text('Open Date Picker'),
              ),
            ),

            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'Selected date: '
                      '${selectedDate!.day}/'
                      '${selectedDate!.month}/'
                      '${selectedDate!.year}',
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
      home: InputControlsDemo(),
    ),
  );
}
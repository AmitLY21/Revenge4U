import 'package:flutter/material.dart';
import '../models/revenge_model.dart';

class RevengeScreen extends StatelessWidget {
  final Revenge revenge;

  RevengeScreen({required this.revenge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revenge Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              revenge.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Person:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              revenge.personName,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              revenge.date,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              revenge.description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Implement the share functionality here
                // For example, you can use the Share plugin to share the revenge details.
              },
              child: Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}

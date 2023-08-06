import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/revenge_model.dart';
import '../widgets/revenge_card.dart';

class LikedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'This page shows all the revenges that you have liked.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          const Divider(
            color: Colors.redAccent,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          Expanded(
            child:
                LikedRevengeList(), // Use the LikedRevengeList widget to display liked revenges
          ),
        ],
      ),
    );
  }
}

class LikedRevengeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('revenge')
          .where('isLiked', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the data is still loading, show a loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          // If there's an error, display an error message
          return const Center(
            child: Text('Error loading data'),
          );
        }

        // If there's data, convert the documents to Revenge objects and display them
        final revenges = snapshot.data!.docs
            .map((doc) => Revenge(
                  id: doc.id,
                  title: doc['title'],
                  personName: doc['personName'],
                  description: doc['description'],
                  date: doc['date'],
                  isLiked: doc['isLiked'],
                  isArchived: doc['isArchived'],
                ))
            .toList();

        if (revenges.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Liked Revenges is empty',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Start adding revenges to your liked list!',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: revenges.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RevengeCard(
                revenge: revenges[index],
                onDelete: () {
                  // Implement the delete function if needed
                },
              ),
            );
          },
        );
      },
    );
  }
}

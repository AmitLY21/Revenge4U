import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:revenge4u/models/revenge_model.dart';
import '../widgets/revenge_card.dart';
import '../widgets/revenge_form_modal.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final CollectionReference revengeCollection =
      FirebaseFirestore.instance.collection('revenge');
  List<Revenge> revengeData = [];
  bool isLoading = true; // Add a loading state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateRevengeModal,
        child: const Icon(Icons.local_fire_department),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getRevengeStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data'),
            );
          }

          revengeData = snapshot.data!.docs
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

          isLoading = false;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 150.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Revenge4U',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Time to settle the score!',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                  background: Container(
                    color: Colors.redAccent,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const Text(
                        'Welcome to Revenge For You!',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Get ready to take revenge with a pinch of humor. Add your revenge tasks and settle the score!',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: RevengeCard(
                        revenge: revengeData[index],
                        onDelete: () {
                          _onDeleteRevenge(index);
                        },
                      ),
                    );
                  },
                  childCount: revengeData.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> _getRevengeStream() {
    return revengeCollection.where('isArchived', isEqualTo: false).snapshots();
  }

  void _showCreateRevengeModal() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return RevengeFormModal(
          onRevengeCreated: (Revenge newRevenge) async {
            try {
              // Add the new revenge to Firestore
              await revengeCollection.doc(newRevenge.id).set({
                'title': newRevenge.title,
                'personName': newRevenge.personName,
                'description': newRevenge.description,
                'date': newRevenge.date,
                'isLiked': false,
                'isArchived': false,
              });

              // Update the UI with the new revenge
              setState(() {
                revengeData.add(newRevenge);
              });

              Navigator.pop(
                  context); // Close the modal sheet after adding the revenge
            } catch (e) {
              // Handle errors here
              print('Error adding revenge to Firestore: $e');
            }
          },
        );
      },
    );
  }

  void _onDeleteRevenge(int index) async {
    try {
      // Remove the revenge from Firestore
      await revengeCollection.doc(revengeData[index].id).delete();

      // Update the UI by removing the revenge from the list
      setState(() {
        revengeData.removeAt(index);
      });
    } catch (e) {
      // Handle errors here
      print('Error deleting revenge from Firestore: $e');
    }
  }
}

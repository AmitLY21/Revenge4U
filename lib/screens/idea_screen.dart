import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/idea_model.dart';
import '../widgets/idea_form_modal.dart';

class IdeaScreen extends StatefulWidget {
  @override
  _IdeaScreenState createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  final CollectionReference ideasCollection =
      FirebaseFirestore.instance.collection('ideas');

  List<Idea> ideas = [];

  @override
  void initState() {
    super.initState();
    _loadIdeas();
  }

  void _loadIdeas() async {
    try {
      QuerySnapshot querySnapshot = await ideasCollection.get();
      List<Idea> loadedIdeas = querySnapshot.docs.map((doc) {
        return Idea(
          title: doc['title'],
          description: doc['description'],
          id: doc.id, // Store the document ID for each idea
        );
      }).toList();

      setState(() {
        ideas = loadedIdeas;
      });
    } catch (e) {
      print('Error loading ideas: $e');
    }
  }

  void _addIdea(String title, String description) async {
    try {
      // Generate a unique ID for the new idea
      String ideaId = FirebaseFirestore.instance.collection('ideas').doc().id;

      await ideasCollection.doc(ideaId).set({
        'title': title,
        'description': description,
      });

      // Reload the list of ideas after adding
      _loadIdeas();
    } catch (e) {
      print('Error adding idea to Firestore: $e');
    }
  }


  void _deleteIdea(String ideaId) async {
    try {
      await ideasCollection.doc(ideaId).delete();

      // Reload the list of ideas after deleting
      _loadIdeas();
    } catch (e) {
      print('Error deleting idea from Firestore: $e');
    }
  }

  void _showAddIdeaModal(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddIdeaModal(onAddIdea: _addIdea);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Idea Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Add your ideas of pranks/revenge here:',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          const Divider(
            color: Colors.redAccent,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: ideas.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.redAccent,
                thickness: 1.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
              itemBuilder: (context, index) {
                final idea = ideas[index];
                return ListTile(
                  title: Text(idea.title),
                  subtitle: Text(idea.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteIdea(idea.id), // Call delete function when the delete icon is tapped
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddIdeaModal(context),
        child: Icon(Icons.lightbulb),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class AddIdeaModal extends StatefulWidget {
  final Function onAddIdea;

  AddIdeaModal({required this.onAddIdea});

  @override
  _AddIdeaModalState createState() => _AddIdeaModalState();
}

class _AddIdeaModalState extends State<AddIdeaModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Add New Idea',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                // Set maxLines to make the description text field bigger
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String title = _titleController.text;
                  String description = _descriptionController.text;
                  if (title.isNotEmpty && description.isNotEmpty) {
                    // Call the onAddIdea function and pass the idea details
                    widget.onAddIdea(title, description);
                    Navigator.pop(context); // Close the modal sheet
                  }
                },
                child: const Text('Add Idea'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

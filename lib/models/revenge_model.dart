import 'package:uuid/uuid.dart'; // Import the uuid package

class Revenge {
  String id; // Add the id field to the class
  final String title;
  final String personName;
  final String description;
  final String date;
  bool isLiked; // Add the isLiked field
  bool isArchived; // Add the isArchived field

  Revenge({
    String? id, // Add an optional named parameter for id
    required this.title,
    required this.personName,
    required this.description,
    required this.date,
    this.isLiked = false, // Initialize isLiked to false by default
    this.isArchived = false, // Initialize isArchived to false by default
  }) : id = id ?? Uuid().v4(); // Use the uuid package to generate a unique id if not provided
}

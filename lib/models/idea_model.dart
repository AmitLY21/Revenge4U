import 'package:uuid/uuid.dart';

class Idea {
  final String id; // UUID for the idea
  final String title;
  final String description;

  Idea({String? id, required this.title, required this.description})
      : id = id ?? const Uuid().v4(); // If id is not provided, generate a new UUID using Uuid package

  // Convert Idea object to a map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // Create Idea object from a map retrieved from Firestore
  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}

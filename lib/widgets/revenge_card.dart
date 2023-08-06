import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/revenge_model.dart';
import '../screens/revenge_screen.dart';

class RevengeCard extends StatefulWidget {
  final Revenge revenge;
  final Function onDelete;

  const RevengeCard({
    required this.revenge,
    required this.onDelete,
  });

  @override
  _RevengeCardState createState() => _RevengeCardState();
}

class _RevengeCardState extends State<RevengeCard> {
  bool isLiked = false;
  bool isArchived = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.redAccent, width: 2.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          widget.revenge.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
              'Person:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.revenge.personName,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 4.0),
            Text(
              'Date:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.revenge.date,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                setState(() {
                  widget.revenge.isLiked = !widget.revenge.isLiked;
                });
                await _updateFirestore(); // Update Firestore when like icon is tapped
              },
              child: Icon(
                widget.revenge.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                size: 28.0,
                color: widget.revenge.isLiked ? Colors.red : Colors.grey,
              ),
            ),
            SizedBox(width: 16.0),
            GestureDetector(
              onTap: () async {
                setState(() {
                  widget.revenge.isArchived = !widget.revenge.isArchived;
                });
                await _updateFirestore(); // Update Firestore when archive icon is tapped
              },
              child: Icon(
                widget.revenge.isArchived ? Icons.archive : Icons.archive_outlined,
                size: 28.0,
                color: widget.revenge.isArchived ? Colors.green : Colors.grey,
              ),
            ),
            SizedBox(width: 16.0),
            GestureDetector(
              onTap: () {
                widget.onDelete();
              },
              child: Icon(
                Icons.delete,
                size: 28.0,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RevengeScreen(revenge: widget.revenge),
            ),
          );        },
      ),
    );
  }

  Future<void> _updateFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('revenge').doc(widget.revenge.id).update({
        'isLiked': widget.revenge.isLiked,
        'isArchived': widget.revenge.isArchived,
      });
    } catch (e) {
      // Handle errors here
      print('Error updating Firestore document: $e');
    }
  }
}

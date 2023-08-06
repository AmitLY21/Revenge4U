import 'package:flutter/material.dart';
import 'package:revenge4u/models/revenge_model.dart';
import 'package:intl/intl.dart';

class RevengeFormModal extends StatefulWidget {
  final Function(Revenge) onRevengeCreated;

  const RevengeFormModal({required this.onRevengeCreated});

  @override
  _RevengeFormModalState createState() => _RevengeFormModalState();
}

class _RevengeFormModalState extends State<RevengeFormModal> {
  TextEditingController titleController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create New Revenge',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.0),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: personNameController,
              decoration: InputDecoration(
                labelText: 'Person Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            OutlinedButton(
              onPressed: () => _selectDate(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8.0),
                    Text(
                      selectedDate == null
                          ? 'Pick a Date'
                          : 'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                String formattedDate = selectedDate != null
                    ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                    : '';
                Revenge newRevenge = Revenge(
                  title: titleController.text,
                  personName: personNameController.text,
                  description: descriptionController.text,
                  date: formattedDate,
                );
                widget.onRevengeCreated(newRevenge);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Create New Revenge',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}

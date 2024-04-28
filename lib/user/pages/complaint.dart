import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintPage extends StatelessWidget {
  final String technicianName;
  final String user;
  final String bookingId;
  final Timestamp bookingTime;
  final String technicianEmail;

  ComplaintPage({
    required this.technicianName,
    required this.user,
    required this.bookingId,
    required this.bookingTime,
    required this.technicianEmail,
  });

  @override
  Widget build(BuildContext context) {
    String description = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Submit a Complaint'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Background color
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.0),
              Text(
                'User: $user',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Technician: $technicianName',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Booking ID: $bookingId',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32.0),
              Text(
                'Describe your complaint:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your complaint here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.all(16.0),
                ),
                maxLines: 5,
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (description.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('Complaints')
                          .add({
                        'technicianname': technicianName,
                        'useremail': user,
                        'bookingId': bookingId,
                        'bookingTime': bookingTime,
                        'technicianEmail': technicianEmail,
                        'complaint': description,
                        'timestamp': DateTime.now(),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Complaint submitted successfully'),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Please provide a description for the complaint'),
                      ));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    child: Text(
                      'Submit Complaint',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Background color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/technician_bookings.dart'; // Import the Booking class

class TechBookingDetailPage extends StatelessWidget {
  final Booking booking;

  TechBookingDetailPage({
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Technician Name: ${booking.technicianName}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Booking ID: ${booking.bookingId}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Booked Time: ${booking.bookedTime.toString()}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Status: ${booking.status ? 'Completed' : 'Pending'}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  if (!booking.status)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _markAsDone(context);
                          },
                          child: Text('Mark as Done?'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _markAsDone(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    // Query bookings where technicianEmail matches booking.technicianEmail
    firestore
        .collection('Bookings')
        .where('technicianEmail', isEqualTo: booking.technicianEmail)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference
        final docRef = querySnapshot.docs.first.reference;
        // Update the status field to true
        docRef.update({'status': true}).then((_) {
          // Show a snackbar to indicate success
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Status updated successfully!'),
          ));
        }).catchError((error) {
          // Show a snackbar to indicate error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to update status: $error'),
          ));
        });
      } else {
        // Show a snackbar if no matching document found
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No matching booking found for this technician.'),
        ));
      }
    }).catchError((error) {
      // Show a snackbar to indicate error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching booking: $error'),
      ));
    });
  }
}

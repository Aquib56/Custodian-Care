import 'package:flutter/material.dart';
import '../pages/bookings.dart'; // Import the Booking class
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore for database operations

class BookingDetailPage extends StatelessWidget {
  final Booking booking;

  BookingDetailPage({
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
                    Text(
                      'The service provider will get to you soon',
                      style: TextStyle(fontSize: 16.0),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            int? rating = await _showRatingDialog(context);
                            if (rating != null) {
                              await _updateTechnicianRating(
                                  booking.technicianName, rating);
                            }
                          },
                          child: Text('Rate'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle complaint button press
                          },
                          child: Text('Complaint'),
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

  Future<int?> _showRatingDialog(BuildContext context) async {
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rate Technician'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Choose a rating between 1 to 10:'),
              SizedBox(height: 20),
              DropdownButton<int>(
                hint: Text('Select Rating'),
                value: 1, // Default value
                items: List.generate(
                  10,
                  (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
                onChanged: (value) {
                  Navigator.of(context).pop(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateTechnicianRating(
      String technicianName, int rating) async {
    try {
      // Fetch the document from Technicians collection
      DocumentSnapshot technicianDoc = await FirebaseFirestore.instance
          .collection('Technicians')
          .doc(technicianName)
          .get();

      if (!technicianDoc.exists) {
        print('Technician document does not exist!');
        return;
      }

      // Update the rating field in the document
      double currentRating = technicianDoc['rating'].toDouble();
      int totalRating = technicianDoc['totalRating'];
      int newTotalRating = totalRating + 1;
      double newRating =
          (currentRating * totalRating + rating) / newTotalRating;

      // Update the document
      await FirebaseFirestore.instance
          .collection('Technicians')
          .doc(technicianName)
          .update({
        'rating': newRating,
        'totalRating': newTotalRating,
      });

      print('Technician rating updated successfully!');
    } catch (e) {
      print('Error updating technician rating: $e');
    }
  }
}

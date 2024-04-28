import 'package:flutter/material.dart';
import '../pages/bookings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/complaint.dart';

class BookingDetailPage extends StatelessWidget {
  final Booking booking;

  BookingDetailPage({
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Bookings')
          .doc(booking.bookingId)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Booking not found'));
        }

        Map<String, dynamic> bookingData =
            snapshot.data!.data() as Map<String, dynamic>;
        Timestamp bookedTime = bookingData['bookedTime'] as Timestamp;

        return Scaffold(
          appBar: AppBar(
            title: Text('Booking Details'),
          ),
          body: Container(
            color: Colors.grey[100], // Light background color
            child: Center(
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
                          'Technician Name: ${bookingData['technicianName']}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Booking ID: ${bookingData['bookingId']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Service Type: ${bookingData['servicetype']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Booked Time: ${_formatTimestamp(bookedTime)}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'User: ${bookingData['user']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Technician Email: ${bookingData['technicianEmail']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 16.0),
                        if (!bookingData['status'])
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
                                  int? rating =
                                      await _showRatingDialog(context);
                                  if (rating != null) {
                                    await _updateTechnicianRating(
                                        bookingData['technicianName'], rating);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue, // Button color
                                  onPrimary: Colors.white, // Text color
                                ),
                                child: Text('Rate'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ComplaintPage(
                                        technicianName:
                                            bookingData['technicianName'],
                                        user: bookingData['user'],
                                        bookingId: bookingData['bookingId'],
                                        bookingTime: bookedTime,
                                        technicianEmail:
                                            bookingData['technicianEmail'],
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue, // Button color
                                  onPrimary: Colors.white, // Text color
                                ),
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
          ),
        );
      },
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
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

import 'package:flutter/material.dart';
import '../pages/bookings.dart'; // Import the Booking class

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
                          onPressed: () {
                            // Handle rating button press
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
}

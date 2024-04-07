import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingConfirmationPage extends StatefulWidget {
  final String technicianName;
  final DateTime bookedTime; // Pass bookedTime in the constructor

  const BookingConfirmationPage(
      {Key? key, required this.technicianName, required this.bookedTime})
      : super(key: key);

  @override
  _BookingConfirmationPageState createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  String? _bookingId;

  Future<void> _generateBookingId() async {
    // Generate a random booking ID
    final String bookingId =
        '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(1000)}';
    setState(() {
      _bookingId = bookingId;
    });
  }

  Future<void> _writeBookingData() async {
    if (_bookingId == null) return; // Handle potential missing ID

    final firestore = FirebaseFirestore.instance;
    final bookingRef = await firestore.collection('Bookings').add({
      'bookingId': _bookingId,
      'technicianName': widget.technicianName,
      'bookedTime': widget.bookedTime,
    });
  }

  @override
  void initState() {
    super.initState();
    _generateBookingId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Booking Confirmed!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              _bookingId != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Booking ID:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          _bookingId!,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : CircularProgressIndicator(), // Show progress indicator while generating ID
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Technician:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    widget.technicianName,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Booked Time:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    // Use custom formatting or library if desired
                    '${widget.bookedTime.year}-${widget.bookedTime.month.toString().padLeft(2, '0')}-${widget.bookedTime.day.toString().padLeft(2, '0')} ${widget.bookedTime.hour.toString().padLeft(2, '0')}:${widget.bookedTime.minute.toString().padLeft(2, '0')}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _writeBookingData(); // Write booking data to Firestore
                  // Optionally, navigate back to a previous page
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

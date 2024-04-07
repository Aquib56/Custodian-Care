import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingsPage extends StatelessWidget {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('Bookings');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        cardColor: Color.fromARGB(253, 255, 255, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bookings'),
          backgroundColor: Colors.blue[100],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: bookings.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final booking = Booking.fromSnapshot(documents[index]);
                return BookingCard(booking: booking);
              },
            );
          },
        ),
      ),
    );
  }
}

class Booking {
  final String technicianName;
  final String bookingId;
  final DateTime bookedTime;

  Booking({
    required this.technicianName,
    required this.bookingId,
    required this.bookedTime,
  });

  factory Booking.fromSnapshot(DocumentSnapshot snapshot) {
    return Booking(
      technicianName: snapshot['technicianName'] as String,
      bookingId: snapshot['bookingId'] as String,
      bookedTime: (snapshot['bookedTime'] as Timestamp).toDate(),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          // Handle booking details navigation if needed
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.technicianName,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Booking ID: ${booking.bookingId}',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              SizedBox(height: 4.0),
              Text(
                'Booked Time: ${booking.bookedTime.toString().substring(0, 10)} ${booking.bookedTime.toString().substring(11, 16)}',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'booking_detail.dart';

class TechBookingsPage extends StatefulWidget {
  @override
  _TechBookingsPageState createState() => _TechBookingsPageState();
}

class _TechBookingsPageState extends State<TechBookingsPage> {
  late Stream<QuerySnapshot> _bookingsStream;
  final CollectionReference _bookings =
      FirebaseFirestore.instance.collection('Bookings');
  bool _showPending = false;

  @override
  void initState() {
    super.initState();
    _bookingsStream = _getUserBookingsStream(_showPending);
  }

  Stream<QuerySnapshot> _getUserBookingsStream(bool showPending) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Return an empty stream if no user is logged in
      return Stream.empty();
    } else {
      // Query bookings where the 'user' field matches the current user's email
      if (showPending) {
        print(user.email);
        return _bookings
            .where('technicianEmail', isEqualTo: user.email)
            .where('status', isEqualTo: false)
            .snapshots();
      } else {
        return _bookings
            .where('technicianEmail', isEqualTo: user.email)
            .where('status', isEqualTo: true)
            .snapshots();
      }
    }
  }

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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showPending = true;
                      _bookingsStream = _getUserBookingsStream(_showPending);
                    });
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.5, 48.0),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text('Pending'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showPending = false;
                      _bookingsStream = _getUserBookingsStream(_showPending);
                    });
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.5, 48.0),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text('Completed'),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _bookingsStream,
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
          ],
        ),
      ),
    );
  }
}

class Booking {
  final String technicianName;
  final String technicianEmail;
  final String bookingId;
  final DateTime bookedTime;
  final bool status; // New field for status

  Booking({
    required this.technicianName,
    required this.technicianEmail,
    required this.bookingId,
    required this.bookedTime,
    required this.status, // Include status in the constructor
  });

  factory Booking.fromSnapshot(DocumentSnapshot snapshot) {
    return Booking(
      technicianName: snapshot['technicianName'] as String,
      technicianEmail: snapshot['technicianEmail'] as String,
      bookingId: snapshot['bookingId'] as String,
      bookedTime: (snapshot['bookedTime'] as Timestamp).toDate(),
      status: snapshot['status'] as bool, // Retrieve status from snapshot
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TechBookingDetailPage(booking: booking),
            ),
          );
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
              SizedBox(height: 4.0),
              Text(
                'Status: ${booking.status ? 'Completed' : 'Pending'}', // Display status
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

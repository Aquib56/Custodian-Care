import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'booking_detail.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  late Stream<QuerySnapshot> _bookingsStream;
  final CollectionReference _bookings =
      FirebaseFirestore.instance.collection('Bookings');
  bool _showPending = true;

  @override
  void initState() {
    super.initState();
    _bookingsStream = _getUserBookingsStream(_showPending);
  }

  Stream<QuerySnapshot> _getUserBookingsStream(bool showPending) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.empty();
    } else {
      return _bookings
          .where('user', isEqualTo: user.email)
          .where('status', isEqualTo: showPending)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent, // Use blueAccent for primary color
        cardColor: Colors.white, // Use white for card background
        toggleableActiveColor: Colors.blueAccent, // Set active toggle color
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
                ToggleButtons(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: _showPending ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: !_showPending ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                  isSelected: [_showPending, !_showPending],
                  onPressed: (int index) {
                    setState(() {
                      _showPending = index == 0;
                      _bookingsStream = _getUserBookingsStream(_showPending);
                    });
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  fillColor: Colors.blueAccent, // Use primary color for fill
                  selectedColor:
                      Colors.blue[800], // Slightly darker blue for selection
                  splashColor: Colors.transparent, // Remove splash effect
                  highlightColor: Colors.transparent, // Remove highlight effect
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _bookingsStream,
                builder: (context, snapshot) {
                  // ... (same error handling and loading indicator logic)

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
  final String bookingId;
  final DateTime bookedTime;
  final bool status; // New field for status

  Booking({
    required this.technicianName,
    required this.bookingId,
    required this.bookedTime,
    required this.status, // Include status in the constructor
  });

  factory Booking.fromSnapshot(DocumentSnapshot snapshot) {
    return Booking(
      technicianName: snapshot['technicianName'] as String,
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
              builder: (context) => BookingDetailPage(booking: booking),
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

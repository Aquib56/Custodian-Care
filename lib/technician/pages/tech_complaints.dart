import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TechComplaintsPage extends StatefulWidget {
  @override
  _TechComplaintsPageState createState() => _TechComplaintsPageState();
}

class _TechComplaintsPageState extends State<TechComplaintsPage> {
  late Stream<QuerySnapshot> _complaintsStream;
  final CollectionReference _complaints =
      FirebaseFirestore.instance.collection('Complaints');

  @override
  void initState() {
    super.initState();
    _complaintsStream = _getUserComplaintsStream();
  }

  Stream<QuerySnapshot> _getUserComplaintsStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Return an empty stream if no user is logged in
      return Stream.empty();
    } else {
      // Query complaints where the 'technicianEmail' field matches the current user's email
      return _complaints
          .where('technicianEmail', isEqualTo: user.email)
          .snapshots();
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
          title: Text('Complaints'),
          backgroundColor: Colors.blue[100],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _complaintsStream,
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
                final complaint = Complaint.fromSnapshot(documents[index]);
                return ComplaintCard(complaint: complaint);
              },
            );
          },
        ),
      ),
    );
  }
}

class Complaint {
  final String technicianName;
  final String technicianEmail;
  final String bookingId;
  final DateTime bookedTime;
  final String complaint;
  final String userEmail;

  Complaint({
    required this.technicianName,
    required this.technicianEmail,
    required this.bookingId,
    required this.bookedTime,
    required this.complaint,
    required this.userEmail,
  });

  factory Complaint.fromSnapshot(DocumentSnapshot snapshot) {
    return Complaint(
      technicianName: snapshot['technicianname'] as String,
      technicianEmail: snapshot['technicianEmail'] as String,
      bookingId: snapshot['bookingId'] as String,
      bookedTime: (snapshot['bookingTime'] as Timestamp).toDate(),
      complaint: snapshot['complaint'] as String,
      userEmail: snapshot['useremail'] as String,
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;

  const ComplaintCard({Key? key, required this.complaint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              complaint.technicianName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Technician Email: ${complaint.technicianEmail}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(height: 4.0),
            Text(
              'Booking ID: ${complaint.bookingId}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(height: 4.0),
            Text(
              'User Email: ${complaint.userEmail}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(height: 4.0),
            Text(
              'Booked Time: ${complaint.bookedTime.toString().substring(0, 16)}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(height: 4.0),
            Text(
              'Complaint: ${complaint.complaint}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

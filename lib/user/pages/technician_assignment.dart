import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/booking_confirmation.dart';

class TechnicianDetailPage extends StatefulWidget {
  final List<String> selectedCategories;

  const TechnicianDetailPage({Key? key, required this.selectedCategories})
      : super(key: key);

  @override
  _TechnicianDetailPageState createState() => _TechnicianDetailPageState();
}

class _TechnicianDetailPageState extends State<TechnicianDetailPage> {
  Technician? _highestRatedTechnician;
  late String _userEmail;
  late int _userPincode;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email!;
      });

      final userQuery = await FirebaseFirestore.instance
          .collection('User')
          .where('email', isEqualTo: _userEmail)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDoc = userQuery.docs.first;
        setState(() {
          _userPincode = userDoc['pincode'] as int;
        });

        _fetchTechnicians();
      }
    }
  }

  Future<void> _fetchTechnicians() async {
    final firestore = FirebaseFirestore.instance;

    // Query technicians based on selected categories
    final query = firestore.collection('Technicians').where(
          'categories',
          arrayContainsAny: widget.selectedCategories,
        );
    // Get all matching technicians
    final snapshot = await query.get();

    print(
        'Number of documents found: ${snapshot.docs.length}'); // Print # of documents

    // Find technician with closest pincode and highest rating
    double minPincodeDifference = double.infinity;
    Technician? closestTechnician;

    snapshot.docs.forEach((doc) {
      final technician = Technician.fromFirestore(doc.data());

      final technicianPincode = doc['pincode'] as int;
      final pincodeDifference =
          (_userPincode - technicianPincode).abs().toDouble();

      if (pincodeDifference < minPincodeDifference ||
          (pincodeDifference == minPincodeDifference &&
              technician.rating > closestTechnician!.rating)) {
        minPincodeDifference = pincodeDifference;
        closestTechnician = technician;
      }
    });

    _highestRatedTechnician = closestTechnician;
    print(_highestRatedTechnician);

    setState(() {}); // Update UI with fetched data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Top Technician for ${widget.selectedCategories.join(', ')}'),
      ),
      body: _highestRatedTechnician != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name: ${_highestRatedTechnician!.name}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Rating: ${_highestRatedTechnician!.rating.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  ElevatedButton(
                    onPressed: () => _initiateBooking(context),
                    child: Text("Confirm"),
                  ),
                  // Optionally display additional details from Technician class
                  Text(
                    'Email: ${_highestRatedTechnician!.email}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> _initiateBooking(BuildContext context) async {
    final technicianName = _highestRatedTechnician!.name;
    final technicianEmail = _highestRatedTechnician!.email;
    final DateTime bookedTime = DateTime.now();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationPage(
          technicianName: technicianName,
          technicianEmail: technicianEmail,
          bookedTime: bookedTime,
        ),
      ),
    );
  }
}

// Define your Technician class with additional fields
class Technician {
  final String name;
  final double rating;
  final List<String> categories;
  final String email;
  final int pincode;

  Technician({
    required this.name,
    required this.rating,
    required this.categories,
    required this.email,
    required this.pincode,
  });

  factory Technician.fromFirestore(Map<String, dynamic> data) => Technician(
        name: data['name'] as String,
        rating: (data['rating'] as num).toDouble(),
        categories: (data['categories'] as List<dynamic>).cast<String>(),
        email: data['email'] as String,
        pincode: data['pincode'] as int, // Ensure pincode is treated as int
      );
}

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

    // Query technicians based on selected categories and isVerified field
    final query = firestore
        .collection('Technicians')
        .where(
          'categories',
          arrayContainsAny: widget.selectedCategories,
        )
        .where('isVerified', isEqualTo: true); // Add condition for isVerified

    // Get all matching technicians
    final snapshot = await query.get();

    print(
        'Number of documents found: ${snapshot.docs.length}'); // Print # of documents

    if (snapshot.docs.isEmpty) {
      // No technicians found for the selected categories
      print('No technicians found for the selected categories.');
      // Show a pop-up dialog to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Technicians Found'),
            content: Text(
                'There are no technicians available for the selected service categories.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

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
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _highestRatedTechnician!.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text(
                              'Rating: ${_highestRatedTechnician!.rating.toStringAsFixed(1)}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(
                              'Email: ${_highestRatedTechnician!.email}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(
                              'Location: ${_highestRatedTechnician!.location}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(
                              'Phone Number: ${_highestRatedTechnician!.phoneNumber}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.pin),
                            title: Text(
                              'Pincode: ${_highestRatedTechnician!.pincode}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.category),
                            title: Text(
                              'Selected Categories:',
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              widget.selectedCategories.join(', '),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: _highestRatedTechnician != null
          ? Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => _initiateBooking(context),
                child: Text(
                  "Confirm Booking",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
              ),
            )
          : null,
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
          selectedCategories: widget.selectedCategories,
        ),
      ),
    );
  }
}

// Define your Technician class with additional fields
class Technician {
  final String name;
  final double rating;
  final String email;
  final int pincode;
  final String location;
  final String phoneNumber;

  Technician({
    required this.name,
    required this.rating,
    required this.email,
    required this.pincode,
    required this.location,
    required this.phoneNumber,
  });

  factory Technician.fromFirestore(Map<String, dynamic> data) => Technician(
        name: data['name'] as String,
        rating: (data['rating'] as num).toDouble(),
        email: data['email'] as String,
        pincode: data['pincode'] as int, // Ensure pincode is treated as int
        location: data['location'] as String,
        phoneNumber: data['phoneNumber'] as String,
      );
}

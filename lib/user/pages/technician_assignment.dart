import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchTechnicians();
  }

  Future<void> _fetchTechnicians() async {
    print("burh=============================");
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

    // Find technician with highest rating
    _highestRatedTechnician = snapshot.docs
        .map((doc) => Technician.fromFirestore(doc.data()))
        .reduce((technician1, technician2) =>
            technician1.rating > technician2.rating
                ? technician1
                : technician2);
    print("Helllo===============================fafa=f");
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
    // Generate a random booking ID (implement in BookingConfirmationPage)
    // final String bookingId = '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(1000)}';

    final technicianName = _highestRatedTechnician!.name;
    final technicianEmail =
        _highestRatedTechnician!.email; // Access email from Technician
    final DateTime bookedTime = DateTime.now();

    // Navigate to BookingConfirmationPage with technician details and booked time
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

  Technician({
    required this.name,
    required this.rating,
    required this.categories,
    required this.email,
  });

  factory Technician.fromFirestore(Map<String, dynamic> data) => Technician(
        name: data['name'] as String,
        rating: (data['rating'] as num).toDouble(),
        categories: (data['categories'] as List<dynamic>).cast<String>(),
        email: data['email'] as String, // Access email from Firestore data
      );
}

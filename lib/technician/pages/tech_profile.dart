import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _email;
  String? _name;
  String? _phone;
  String? _address;

  @override
  void initState() {
    super.initState();
    // Fetch the current user's email on initialization
    _getCurrentUserEmail();
  }

  Future<void> _getCurrentUserEmail() async {
    // Get the current user's email from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _email = user.email;
      });

      final technicianQuery = await FirebaseFirestore.instance
          .collection('Technicians')
          .where('email', isEqualTo: _email)
          .limit(1)
          .get();

      if (technicianQuery.docs.isNotEmpty) {
        final technicianDoc =
            technicianQuery.docs.first.data() as Map<String, dynamic>;
        setState(() {
          _name = technicianDoc['name'];
          _phone = technicianDoc['phoneNumber'];
          _address = technicianDoc['address'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _email == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching email
          : Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  ProfileField(label: 'Name', value: _name ?? ''),
                  SizedBox(height: 40),
                  ProfileField(label: 'Email', value: _email ?? ''),
                  SizedBox(height: 40),
                  ProfileField(label: 'Phone', value: _phone ?? ''),
                  SizedBox(height: 40),
                  ProfileField(label: 'Address', value: _address ?? ''),
                  SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '$label ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 10), // Add spacing between label and value
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

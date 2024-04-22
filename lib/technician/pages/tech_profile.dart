import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/user/pages/edit_profilepage.dart'; // Import LoginPage
import '/user/pages/preLogin.dart'; // Import EditProfilePage

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _technicianName;
  String? _technicianEmail;
  String? _technicianLocation;
  String? _technicianPhoneNumber;
  int? _technicianPincode;
  List<String>? _technicianCategories;
  double? _technicianRating;

  @override
  void initState() {
    super.initState();
    _getTechnicianData();
  }

  Future<void> _getTechnicianData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('1111111111111111111111111111111111111111111111');
      setState(() {
        _technicianEmail = user.email;
      });

      final technicianQuery = await FirebaseFirestore.instance
          .collection('Technicians')
          .where('email', isEqualTo: _technicianEmail)
          .limit(1)
          .get();

      if (technicianQuery.docs.isNotEmpty) {
        final technicianData =
            technicianQuery.docs.first.data() as Map<String, dynamic>;
        setState(() {
          _technicianName = technicianData['name'];
          _technicianLocation = technicianData['location'];
          _technicianPhoneNumber = technicianData['phoneNumber'];
          _technicianPincode = technicianData['pincode'];
          _technicianCategories =
              List<String>.from(technicianData['categories']);
          _technicianRating = technicianData['rating'].toDouble();
        });
      }
    }
  }

  Future<void> _logout() async {
    bool confirmLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Return false when Cancel is pressed
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Return true when Yes is pressed
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PreLoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _technicianName != null ? 'Welcome, $_technicianName' : 'Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.email, color: Colors.blueAccent),
              title: Text('Email', style: TextStyle(fontSize: 18)),
              subtitle: Text(_technicianEmail ?? 'N/A',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.blueAccent),
              title: Text('Name', style: TextStyle(fontSize: 18)),
              subtitle: Text(_technicianName ?? 'N/A',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on, color: Colors.blueAccent),
              title: Text('Location', style: TextStyle(fontSize: 18)),
              subtitle: Text(_technicianLocation ?? 'N/A',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              title: Text('Phone Number', style: TextStyle(fontSize: 18)),
              subtitle: Text(_technicianPhoneNumber ?? 'N/A',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.pin_drop, color: Colors.blueAccent),
              title: Text('Pincode', style: TextStyle(fontSize: 18)),
              subtitle: Text(
                  _technicianPincode != null
                      ? _technicianPincode.toString()
                      : 'N/A',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.category, color: Colors.blueAccent),
              title: Text('Categories', style: TextStyle(fontSize: 18)),
              subtitle: _technicianCategories != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _technicianCategories!
                          .map((category) => Text(
                                '- $category',
                                style: TextStyle(fontSize: 16),
                              ))
                          .toList(),
                    )
                  : Text('N/A', style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.blueAccent),
              title: Text('Rating', style: TextStyle(fontSize: 18)),
              subtitle: Text(
                  _technicianRating != null
                      ? _technicianRating.toString()
                      : 'N/A',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _logout,
          child: Text('Logout', style: TextStyle(fontSize: 18.0)),
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent, // Set button color to blue
          ),
        ),
      ),
    );
  }
}

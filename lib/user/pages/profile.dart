import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/edit_profilepage.dart'; // Import LoginPage
import '../pages/preLogin.dart'; // Import EditProfilePage

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _userName;
  String? _userEmail;
  String? _userLocation;
  String? _userPhoneNumber;
  int? _userPincode;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email;
      });

      final userQuery = await FirebaseFirestore.instance
          .collection('User')
          .where('email', isEqualTo: _userEmail)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userData = userQuery.docs.first.data() as Map<String, dynamic>;
        setState(() {
          _userName = '${userData['firstName']} ${userData['lastName']}';
          _userLocation = userData['location'];
          _userPhoneNumber = userData['phoneNumber'];
          _userPincode = userData['pincode'];
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
        title: Text(_userName != null ? 'Welcome, $_userName' : 'Welcome'),
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
              subtitle:
                  Text(_userEmail ?? 'N/A', style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.blueAccent),
              title: Text('Name', style: TextStyle(fontSize: 18)),
              subtitle:
                  Text(_userName ?? 'N/A', style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on, color: Colors.blueAccent),
              title: Text('Location', style: TextStyle(fontSize: 18)),
              subtitle:
                  Text(_userLocation ?? 'N/A', style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              title: Text('Phone Number', style: TextStyle(fontSize: 18)),
              subtitle: Text(_userPhoneNumber ?? 'N/A',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.pin_drop, color: Colors.blueAccent),
              title: Text('Pincode', style: TextStyle(fontSize: 18)),
              subtitle: Text(
                  _userPincode != null ? _userPincode.toString() : 'N/A',
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
          child: Text('Logout',
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent, // Set button color to blue
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userQuery = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.email)
          .get();

      if (userQuery.exists) {
        final userData = userQuery.data() as Map<String, dynamic>;
        setState(() {
          _firstNameController.text = userData['firstName'];
          _lastNameController.text = userData['lastName'];
          _addressController.text = userData['location'];
          _pincodeController.text = userData['pincode'].toString();
          _phoneNumberController.text = userData['phoneNumber'];
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.email)
          .update({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'location': _addressController.text.trim(),
        'pincode': int.parse(_pincodeController.text.trim()),
        'phoneNumber': _phoneNumberController.text.trim(),
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Profile Updated'),
            content: Text('Your profile has been updated successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              _buildInputField(_firstNameController, 'First Name'),
              _buildInputField(_lastNameController, 'Last Name'),
              _buildInputField(_addressController, 'Address'),
              _buildInputField(_pincodeController, 'Pincode',
                  keyboardType: TextInputType.number),
              _buildInputField(_phoneNumberController, 'Phone Number',
                  keyboardType: TextInputType.phone),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

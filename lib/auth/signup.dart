import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              // App logo
              Image.asset(
                'assets/logo1.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20.0),
              _buildInputField(_firstNameController, 'First Name'),
              _buildInputField(_lastNameController, 'Last Name'),
              _buildInputField(_emailController, 'Email',
                  keyboardType: TextInputType.emailAddress),
              _buildInputField(_phoneNumberController, 'Phone Number',
                  keyboardType: TextInputType.phone),
              _buildInputField(_passwordController, 'Password',
                  isPassword: true),
              _buildInputField(_confirmPasswordController, 'Confirm Password',
                  isPassword: true),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await _signUpWithEmailAndPassword();
                },
                // child: const Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Custom button color
                  elevation: 5, // Shadow depth
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Custom border radius
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15), // Custom padding
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 18, color: Colors.white), // Custom text style
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build custom input field
  Widget _buildInputField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text,
      bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Custom border radius
          ),
        ),
      ),
    );
  }

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      // Validate password
      if (_passwordController.text.trim() !=
          _confirmPasswordController.text.trim()) {
        setState(() {
          _errorMessage = 'Passwords do not match.';
        });
        return;
      }

      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save additional user details to Firestore
      await FirebaseFirestore.instance
          .collection('User')
          .doc(_emailController.text.trim())
          .set({
        'FirstName': _firstNameController.text.trim(),
        'LastName': _lastNameController.text.trim(),
        'Email': _emailController.text.trim(),
        'PhoneNo': _phoneNumberController.text.trim(),
      });
      // Clear error message if sign up is successful
      setState(() {
        _errorMessage = '';
      });
      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign Up Successful'),
            content: const Text('Your account has been successfully created.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pushReplacement(
                    // Navigate back to login page
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          _errorMessage = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _errorMessage = 'The account already exists for that email.';
        });
      }
    } catch (e) {
      print(
          '===============================================================================================');
      print(e);
      setState(() {
        _errorMessage = 'Sign up failed. Please try again later.';
      });
    }
  }
}

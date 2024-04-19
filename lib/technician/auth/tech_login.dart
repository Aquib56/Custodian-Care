import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/tech_signup.dart';
import '../../user/auth/forgot_password.dart';
import '../tech_nav.dart';
import '../auth/not_verified_page.dart'; // Import NotVerifiedPage

class TechLoginPage extends StatefulWidget {
  @override
  _TechLoginPageState createState() => _TechLoginPageState();
}

class _TechLoginPageState extends State<TechLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              Image.asset(
                'assets/logo1.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20.0),
              _buildInputField(_emailController, 'Email Id'),
              _buildInputField(_passwordController, 'Password'),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await _signInWithEmailAndPassword();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TechSignupPage()));
                    },
                    child: const Text("Don't have an account? SignUp"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Check if the email is registered as a technician
      bool isRegistered =
          await _checkTechnicianRegistration(_emailController.text.trim());

      if (isRegistered) {
        // Check if the technician is verified
        bool isVerified =
            await _checkTechnicianVerification(_emailController.text.trim());

        if (isVerified) {
          // Clear error message if sign in is successful
          setState(() {
            _errorMessage = '';
          });

          // Navigate to home page after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TechBottomNavBar()),
          );
        } else {
          // Navigate to NotVerifiedPage if not verified
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NotVerifiedPage()),
          );
        }
      } else {
        setState(() {
          _errorMessage = 'You are not registered as a technician.';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = 'Email or Password incorrect.';
      });
    } catch (e) {
      print('Error during login: $e');
      setState(() {
        _errorMessage = 'Error during login. Please try again.';
      });
    }
  }

  Future<bool> _checkTechnicianRegistration(String email) async {
    try {
      // Query the "Technicians" collection for the provided email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Technicians')
          .where('email', isEqualTo: email)
          .get();

      // If there's at least one document with the provided email, return true
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking technician registration: $e');
      // Return false if any error occurs during the process
      return false;
    }
  }

  Future<bool> _checkTechnicianVerification(String email) async {
    try {
      // Query the "Technicians" collection for the provided email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Technicians')
          .where('email', isEqualTo: email)
          .where('isVerified', isEqualTo: true)
          .get();

      // If there's at least one verified document with the provided email, return true
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking technician verification: $e');
      // Return false if any error occurs during the process
      return false;
    }
  }
}

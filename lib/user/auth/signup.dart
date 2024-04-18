import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _imageFile; // Declare _imageFile as nullable
  String _errorMessage = '';
  String _uploadMessage = '';

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
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            Colors.grey, // You can change the border color here
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Legal Document for Verification',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      _pickImage();
                    },
                    child: const Text('Upload Image'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await _signUpWithEmailAndPassword();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10.0),
              Text(
                _uploadMessage,
                style: TextStyle(color: Colors.green),
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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery); // Use pickImage instead of getImage

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _uploadMessage = 'Image uploaded successfully';
      });
    } else {
      // User canceled the image picking process
      // You can handle this scenario as per your requirement
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      if (_passwordController.text.trim() !=
          _confirmPasswordController.text.trim()) {
        setState(() {
          _errorMessage = 'Passwords do not match.';
        });
        return;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final String? userId = userCredential.user?.uid; // Make userId nullable

      String imageUrl = ''; // Initialize imageUrl here

      if (_imageFile != null) {
        String email =
            _emailController.text.trim(); // Get the email entered by the user
        String fileName = '$email.jpg'; // Generate filename using user's email

        Reference ref = FirebaseStorage.instance
            .ref()
            .child('user_profile_images')
            .child(fileName);

        UploadTask uploadTask = ref.putFile(_imageFile!);

        // Update imageUrl if upload is successful
        try {
          await uploadTask;
          imageUrl = await ref.getDownloadURL();
        } catch (e) {
          print('Error uploading file: $e');
          // Handle error
        }
      }

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phoneNumber': _phoneNumberController.text.trim(),
        'profileImageUrl': imageUrl,
      });

      setState(() {
        _errorMessage = '';
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign Up Successful'),
            content: const Text('Your account has been successfully created.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
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
      setState(() {
        _errorMessage = 'Sign up failed. Please try again later.';
      });
    }
  }
}

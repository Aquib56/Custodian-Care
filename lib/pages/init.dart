import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate loading delay with Future.delayed
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to your home page or another page after 2 seconds
      Navigator.pushReplacementNamed(context, '/home');
    });

    return Scaffold(
      backgroundColor: Colors.white, // Set background color as needed
      body: Center(
        child: Image.asset(
          'assets/logo1.png', // Replace 'your_logo.png' with your logo asset path
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          // You can add more properties like width and height to customize the logo size
        ),
      ),
    );
  }
}

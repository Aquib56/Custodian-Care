import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:custodiancare/pages/signup.dart';
import 'package:custodiancare/main.dart';  // Adjust the project name accordingly
import 'package:custodiancare/pages/forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // await _signInWithEmailAndPassword();
                try {
                  await _auth.signInWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                  // Navigate to the Home page or another authenticated page
                } catch (e) {
                  // Handle login errors
                  print('Login failed: $e');
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Signup page
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: Text('Don\'t have an account? Sign up'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Forgot Password page
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
              },
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to the Home page or another authenticated page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Handle login errors
      print('Login failed: $e');
    }
  }
}

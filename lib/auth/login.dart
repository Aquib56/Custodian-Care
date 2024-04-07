import 'package:custodiancare/components/nav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/home.dart'; // Import your home page
import '../auth/signup.dart'; // Import your signup page
import '../auth/forgot_password.dart'; // Import your forgot password page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

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
                await _signInWithEmailAndPassword();
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: Text("Don't have an account? SignUp"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()));
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
          ],
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
      // Clear error message if sign in is successful
      setState(() {
        _errorMessage = '';
      });
      // Navigate to home page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
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
}





// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../auth/signup.dart';
// import 'package:custodiancare/main.dart'; // Adjust the project name accordingly
// import '../auth/forgot_password.dart';
// import '../pages/home.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () async {
//                 // await _signInWithEmailAndPassword();
//                 try {
//                   await _auth.signInWithEmailAndPassword(
//                     email: _emailController.text.trim(),
//                     password: _passwordController.text.trim(),
//                   );
//                   // Navigate to the Home page or another authenticated page
//                 } catch (e) {
//                   // Handle login errors
//                   print('Login failed: $e');
//                 }
//               },
//               child: Text('Login'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate to Signup page
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => SignupPage()));
//               },
//               child: Text('Don\'t have an account? Sign up'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate to Forgot Password page
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ForgotPasswordPage()));
//               },
//               child: Text('Forgot Password?'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _signInWithEmailAndPassword() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       // Navigate to the Home page or another authenticated page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     } catch (e) {
//       // Handle login errors
//       print('Login failed: $e');
//     }
//   }
// }

import 'package:flutter/material.dart';
import '/user/auth/login.dart';
import '/technician/auth/tech_login.dart';

// Import the technician home page

class PreLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login as?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login as?',
              style: TextStyle(
                fontSize: 24,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the user home page when Customer button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: Icon(Icons.person),
                label: Text('Customer'),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Login as a customer to access your account',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the technician home page when Technician button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TechLoginPage()),
                  );
                },
                icon: Icon(Icons.work),
                label: Text('Technician'),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Login as a technician to manage tasks',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

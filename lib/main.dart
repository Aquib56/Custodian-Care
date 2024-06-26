import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../user/components/nav.dart';
import '../user/pages/init.dart';
import '../user/pages/preLogin.dart';
import '../user/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
  // runApp(MyApp());
}

// Test
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Management App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // This line removes the debug banner
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/choice': (context) => PreLoginPage(),
        '/login': (context) => LoginPage(),
        // '/login': (context) => BottomNavBar(),
        // Add more routes as needed
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../pages/home.dart';
import '../components/nav.dart';
import '../pages/init.dart';
import 'package:get/get.dart';

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
        '/home': (context) => BottomNavBar(),
        // Add more routes as needed
      },
    );
  }
}

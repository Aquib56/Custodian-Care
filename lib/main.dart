import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; //
import 'pages/login.dart';
import 'pages/services.dart';
import 'pages/complaints.dart';
import 'pages/notifications.dart';
import 'pages/profile.dart';
import 'pages/signup.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Management App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,  // This line removes the debug banner
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo1.png', height: 50.0),
            SizedBox(width: 10.0),
            // Text('Service App'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Implement profile button functionality
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );

            },
          ),
        ],
      ),
      body: Column(

        children: [

          YourCarousel([
            'assets/img1.png',
            'assets/img2.png',
            'assets/img3.png',
          ]),
          // Add other widgets as needed below the carousel

          SizedBox(height: 10.0),
          buildServices(context),

        ],

      ),

    );
  }
}

class YourCarousel extends StatelessWidget {
  final List<String> imagePaths;

  YourCarousel(this.imagePaths);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 250,
        enlargeCenterPage: true,
      ),
      items: imagePaths.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  // fit: BoxFit.fill,
                  fit:BoxFit.contain,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

Widget buildServices(BuildContext context) {
  return Column(
    children: [
      Text(
        'Services',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      GridView.builder(
        // shrinkWrap: true, // Prevents unexpected scrolling
        // physics: NeverScrollableScrollPhysics(), // Disables scroll
        // itemCount: services.length,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 2, // Two columns of service tiles
        //   crossAxisSpacing: 10.0,
        //   mainAxisSpacing: 10.0,
        shrinkWrap: true, // Prevents unexpected scrolling
        physics: NeverScrollableScrollPhysics(), // Disables scroll
        itemCount: services.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Four columns of service tiles
          crossAxisSpacing: 10.0, // Space between tiles horizontally
          mainAxisSpacing: 10.0, // Space between tiles vertically
        ),
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => service.page),
            ),
            child: ServiceTileCard(imagePath: service.imagePath, title: service.title),
          );
        },
      ),
    ],
  );
}

class ServiceTileCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const ServiceTileCard({
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            // width: 50.0,
            width: 75.0, // Limit image width
            height: 40.0,
          ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}


class ServiceTile {
  final String imagePath;
  final String title;
  final Widget page; // This will hold the page to navigate to on click

  const ServiceTile({
    required this.imagePath,
    required this.title,
    required this.page,
  });
}


final List<ServiceTile> services = [
  ServiceTile(
    imagePath: 'assets/painting.png',
    title: 'Painting',
    // page: PaintingPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/ac_repair.png',
    title: 'AC Repair',
    // page: ACRepairPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/gardener.png',
    title: 'Gardener',
    // page: GardenerPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/maid.png',
    title: 'Maid',
    // page: MaidPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/hairdresser.png',
    title: 'Hair Care',
    // page: MaidPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/pest-control.png',
    title: 'Pest Control',
    // page: MaidPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/teacher.png',
    title: 'Tutions',
    // page: MaidPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/electrician.png',
    title: 'Electrician',
    // page: MaidPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/plumber.png',
    title: 'Plumbing',
    // page: MaidPage(),
    page: LoginPage(),
  ),
  ServiceTile(
    imagePath: 'assets/aio.png',
    title: 'Others',
    // page: MaidPage(),
    page: LoginPage(),
  ),
];


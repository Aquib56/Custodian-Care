import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_svg/flutter_svg.dart'; //
import 'pages/signup&login/login.dart';
import 'pages/services/service_detail_page.dart';

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
      home: HomePage(),
      routes: const {
        // '/booking_details': (context) => BookingDetailsPage(), // Define the route for booking details page
      },
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
            const SizedBox(width: 10.0),
            // Text('Service App'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
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
          YourCarousel(const [
            'assets/img1.png',
            'assets/img2.png',
            'assets/img3.png',
          ]),
          // Add other widgets as needed below the carousel

          const SizedBox(height: 10.0),
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
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  // fit: BoxFit.fill,
                  fit: BoxFit.contain,
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
      const Text(
        'Services',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10.0),
      GridView.builder(
        shrinkWrap: true, // Prevents unexpected scrolling
        physics: const NeverScrollableScrollPhysics(), // Disables scroll
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Four columns of service tiles
          crossAxisSpacing: 10.0, // Space between tiles horizontally
          mainAxisSpacing: 10.0, // Space between tiles vertically
        ),
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              // service.page
              MaterialPageRoute(
                builder: (context) => ServiceDetailPage(
                  imagePath: service.imagePath,
                  banner: service.banner,
                  title: service.title,
                  category: service.category,
                  description: service.description,
                  price: service.price,
                  ratings: service.ratings,
                  photos: service.photos,
                ),
              ),
            ),
            child: ServiceTileCard(
                imagePath: service.imagePath, title: service.title),
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
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 75.0, // Limit image width
            height: 40.0,
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: const TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}

class ServiceTile {
  final String imagePath;
  final String banner;
  final String title;
  final String description;
  // final Widget page; // This will hold the page to navigate to on click
  final String category;
  final double price;
  final double ratings;
  final List<String> photos;

  const ServiceTile({
    required this.imagePath,
    required this.banner,
    required this.title,
    required this.description,
    // required this.page,
    required this.category,
    required this.price,
    required this.ratings,
    required this.photos,
  });
}

final List<ServiceTile> services = [
  const ServiceTile(
    imagePath: 'assets/painting.png',
    banner: 'assets/banners/sampleJob1.jpg',
    title: 'Painting',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
  const ServiceTile(
    imagePath: 'assets/ac_repair.png',
    title: 'AC Repair',
    banner: 'assets/banners/ac_repair_banner.jpg',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
  const ServiceTile(
    imagePath: 'assets/gardener.png',
    title: 'Gardener',
    banner: 'assets/banners/sampleJob1.jpg',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
  const ServiceTile(
    imagePath: 'assets/maid.png',
    title: 'Maid',
    banner: 'assets/banners/sampleJob1.jpg',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
  const ServiceTile(
    imagePath: 'assets/hairdresser.png',
    title: 'Hair Care',
    banner: 'assets/banners/sampleJob1.jpg',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
  const ServiceTile(
    imagePath: 'assets/pest-control.png',
    title: 'Pest Control',
    banner: 'assets/banners/sampleJob1.jpg',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
  const ServiceTile(
    imagePath: 'assets/teacher.png',
    title: 'Tutions',
    banner: 'assets/banners/sampleJob1.jpg',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
  const ServiceTile(
    imagePath: 'assets/electrician.png',
    title: 'Electrician',
    banner: 'assets/banners/sampleJob1.jpg',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
  const ServiceTile(
    imagePath: 'assets/plumber.png',
    title: 'Plumbing',
    banner: 'assets/banners/sampleJob1.jpg',
    category: 'Home Services',
    price: 100.0,
    ratings: 4.5,
    description:
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    photos: ['assets/banners/sampleJob1.jpg', 'assets/banners/sampleJob1.jpg'],
  ),
];

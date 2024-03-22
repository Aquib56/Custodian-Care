import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../auth/login.dart';
import '../pages/navbar.dart';
import '../pages/servicepage.dart';
import '../pages/category.dart';
import '../pages/profile.dart';
import '../data/serviceMap.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  // Dimensions used for service cards
  Map<String, double> ServiceCardDimensions = {
    "servicesHeight": 80,
    "serviceWidth": 140,
  };
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      } else if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryPage()),
        );
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      }
    });
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            YourCarousel([
              'assets/img1.png',
              'assets/img2.png',
              'assets/img3.png',
            ]),
            // Add other widgets as needed below the carousel
            // SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0), // Adjust the left padding as needed
                  child: Text(
                    'Our Services',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    );
                    // Action to perform when the button is pressed
                  },
                  child: Text('All Services >'),
                ),
              ],
            ),
            SizedBox(height: 2.0),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyCard(
                      imagePath: 'assets/cleaning.png',
                      name: 'Cleaning',
                      pageRoute: ServiceDetailPage(
                        serviceData: services,
                        index: 0,
                      ),
                      cardheight:
                          ServiceCardDimensions["servicesHeight"] ?? 100,
                      cardwidth: 120,
                    ),
                    MyCard(
                      imagePath: 'assets/electrician.png',
                      name: 'Electrician',
                      pageRoute: ServiceDetailPage(
                        serviceData: services,
                        index: 0,
                      ),
                      cardheight:
                          ServiceCardDimensions["servicesHeight"] ?? 100,
                      cardwidth: 120,
                    ),
                    MyCard(
                      imagePath: 'assets/painting.png',
                      name: 'Painting',
                      pageRoute: ServiceDetailPage(
                        serviceData: services,
                        index: 0,
                      ),
                      cardheight:
                          ServiceCardDimensions["servicesHeight"] ?? 120,
                      cardwidth: 120,
                    ),
                  ],
                ),
                SizedBox(
                    height: 0), // Adjust the spacing between rows as needed
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyCard(
                      imagePath: 'assets/plumber.png',
                      name: 'Plumber',
                      pageRoute: ServiceDetailPage(
                        serviceData: services,
                        index: 0,
                      ),
                      cardheight:
                          ServiceCardDimensions["servicesHeight"] ?? 120,
                      cardwidth: 120,
                    ),
                    MyCard(
                      imagePath: 'assets/maid.png',
                      name: 'Maid',
                      pageRoute: ServiceDetailPage(
                        serviceData: services,
                        index: 0,
                      ),
                      cardheight:
                          ServiceCardDimensions["servicesHeight"] ?? 120,
                      cardwidth: 120,
                    ),
                    MyCard(
                      imagePath: 'assets/hairdresser.png',
                      name: 'Hairdresser',
                      pageRoute: ServiceDetailPage(
                        serviceData: services,
                        index: 0,
                      ),
                      cardheight:
                          ServiceCardDimensions["servicesHeight"] ?? 120,
                      cardwidth: 120,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Nigga',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MyCard2(
                    imagePath: 'assets/img1.png',
                    name: 'Name 1',
                    pageRoute: LoginPage(),
                    cardheight: 200,
                    cardwidth: 200,
                  ),
                ),
                Expanded(
                  child: MyCard(
                    imagePath: 'assets/hairdresser.png',
                    name: 'Name 1',
                    pageRoute: LoginPage(),
                    cardheight: 200,
                    cardwidth: 200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        onItemTap: _onItemTapped,
        currentIndex: _currentIndex,
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
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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

class MyCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final double cardheight;
  final double cardwidth;
  final Widget pageRoute;

  const MyCard(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.pageRoute,
      required this.cardheight,
      required this.cardwidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pageRoute),
        );
      },
      child: Card(
        elevation: 5,
        // color: Colors.cyan[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: cardwidth, // Adjust the width of the image as needed
              height: cardheight, // Adjust the height of the image as needed
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard2 extends StatelessWidget {
  final String imagePath;
  final String name;
  final double cardheight;
  final double cardwidth;
  final Widget pageRoute;

  const MyCard2(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.pageRoute,
      required this.cardheight,
      required this.cardwidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pageRoute),
        );
      },
      child: Card(
        elevation: 10,
        // color: Colors.cyan[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: cardwidth, // Adjust the width of the image as needed
              height: cardheight, // Adjust the height of the image as needed
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Mohsin

// Widget buildServices(BuildContext context) {
//   return Column(
//     children: [
//       Text(
//         'Services',
//         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(height: 10.0),
//       GridView.builder(
//         // shrinkWrap: true, // Prevents unexpected scrolling
//         // physics: NeverScrollableScrollPhysics(), // Disables scroll
//         // itemCount: services.length,
//         // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         //   crossAxisCount: 2, // Two columns of service tiles
//         //   crossAxisSpacing: 10.0,
//         //   mainAxisSpacing: 10.0,
//         shrinkWrap: true, // Prevents unexpected scrolling
//         physics: NeverScrollableScrollPhysics(), // Disables scroll
//         itemCount: services.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4, // Four columns of service tiles
//           crossAxisSpacing: 10.0, // Space between tiles horizontally
//           mainAxisSpacing: 10.0, // Space between tiles vertically
//         ),
//         itemBuilder: (context, index) {
//           final service = services[index];
//           return GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => service.page),
//             ),
//             child: ServiceTileCard(
//                 imagePath: service.imagePath, title: service.title),
//           );
//         },
//       ),
//     ],
//   );
// }

// class ServiceTileCard extends StatelessWidget {
//   final String imagePath;
//   final String title;

//   const ServiceTileCard({
//     required this.imagePath,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(5.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             imagePath,
//             // width: 50.0,
//             width: 75.0, // Limit image width
//             height: 40.0,
//           ),
//           SizedBox(height: 10.0),
//           Text(
//             title,
//             style: TextStyle(fontSize: 14.0),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ServiceTile {
//   final String imagePath;
//   final String title;
//   final Widget page; // This will hold the page to navigate to on click

//   const ServiceTile({
//     required this.imagePath,
//     required this.title,
//     required this.page,
//   });
// }

// final List<ServiceTile> services = [
//   ServiceTile(
//     imagePath: 'assets/painting.png',
//     title: 'Painting',
//     // page: PaintingPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/iconsimg2.png',
//     title: 'AC Repair',
//     // page: ACRepairPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/gardener.png',
//     title: 'Gardener',
//     // page: GardenerPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/maid.png',
//     title: 'Maid',
//     // page: MaidPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/hairdresser.png',
//     title: 'Hair Care',
//     // page: MaidPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/pest-control.png',
//     title: 'Pest Control',
//     // page: MaidPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/teacher.png',
//     title: 'Tutions',
//     // page: MaidPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/electrician.png',
//     title: 'Electrician',
//     // page: MaidPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/plumber.png',
//     title: 'Plumbing',
//     // page: MaidPage(),
//     page: LoginPage(),
//   ),
//   ServiceTile(
//     imagePath: 'assets/aio.png',
//     title: 'Others',
//     // page: MaidPage(),
//     page: LoginPage(),
//   ),
// ];
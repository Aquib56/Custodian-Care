import 'package:flutter/material.dart';
import '../user/pages/home.dart';
import '../user/pages/category.dart';
import 'pages/technician_bookings.dart';
import 'pages/tech_complaints.dart';
import 'pages/tech_profile.dart';

class TechBottomNavBar extends StatefulWidget {
  @override
  _TechBottomNavBarState createState() => _TechBottomNavBarState();
}

class _TechBottomNavBarState extends State<TechBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    TechBookingsPage(),
    TechComplaintsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.link),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_rounded),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_sharp),
            label: 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// class CustomBottomNavigationBar extends StatelessWidget {
//   final Function(int) onTabChange;

//   const CustomBottomNavigationBar({Key? key, required this.onTabChange})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GNav(
//       backgroundColor: Colors.white,
//       color: Colors.black,
//       activeColor: Colors.white,
//       tabBackgroundColor: Colors.blue,
//       gap: 8,
//       onTabChange: onTabChange,
//       padding: EdgeInsets.all(16),
//       tabs: const [
//         GButton(
//           icon: Icons.home,
//           text: 'Home',
//         ),
//         GButton(
//           icon: Icons.search,
//           text: 'Search',
//         ),
//         GButton(
//           icon: Icons.shopping_cart,
//           text: 'Cart',
//         ),
//         GButton(
//           icon: Icons.person,
//           text: 'Profile',
//         ),
//       ],
//     );
//   }

//   void _onTabChange(int index) {
//     switch (index) {
//       case 0:
//         Get.offAll(() => HomePage()); // Navigate to Home Page
//         break;
//       case 1:
//         Get.offAll(() => LoginPage()); // Navigate to Search Page
//         break;
//       case 2:
//         Get.offAll(() => CategoryPage()); // Navigate to Cart Page
//         break;
//       case 3:
//         Get.offAll(() => ProfilePage()); // Navigate to Profile Page
//         break;
//       default:
//         break;
//     }
//   }
// }

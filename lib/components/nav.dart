import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../pages/home.dart';
import '../pages/category.dart';
import '../pages/profile.dart';
import '../auth/login.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    CategoryPage(),
    LoginPage(),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Seach',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
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

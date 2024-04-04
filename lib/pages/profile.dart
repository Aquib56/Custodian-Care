import 'package:flutter/material.dart';
import '../pages/navbar.dart';
import '../pages/home.dart';
import '../pages/category.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 4;
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
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Handle account icon action
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Sign in'),
            subtitle: Text('Access your account and personalized features.'),
            onTap: () {
              // Handle sign in action
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Wishlist'),
            subtitle: Text('Create and manage your desired items.'),
            onTap: () {
              // Handle wishlist action
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Address'),
            subtitle: Text('Manage your shipping and billing information.'),
            onTap: () {
              // Handle address action
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Orders'),
            subtitle: Text('Find order updates, returns, and cancellations.'),
            onTap: () {
              // Handle orders action
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Wallet'),
            subtitle: Text('Manage your wallet and transactions.'),
            onTap: () {
              // Handle wallet action
            },
          ),
        ],
      ),
    );
  }
}

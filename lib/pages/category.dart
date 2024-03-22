import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Categories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CategoryPage(),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'General cleaning',
      'description':
          'Bring your furniture to our experienced professionals for a service...',
      'icon': Icons.cleaning_services,
    },
    {
      'title': 'Handyman & maintenance',
      'description':
          'This includes checking the roof, gutters, siding windows doors...',
      'icon': Icons.build,
    },
    // Add other categories here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(categories[index]['icon']),
              title: Text(categories[index]['title']),
              subtitle: Text(categories[index]['description']),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle navigation to category details
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

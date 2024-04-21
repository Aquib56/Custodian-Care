import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../pages/servicepage.dart';
import '../data/serviceMap.dart';

class CategoryPage extends StatelessWidget {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('serviceCategories');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        cardColor: Color.fromARGB(253, 255, 255, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue[100],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: categories.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final category = Category.fromSnapshot(documents[index]);
                return CategoryCard(category: category);
              },
            );
          },
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final String imageURL;
  final String description;

  const Category({
    required this.name,
    required this.imageURL,
    required this.description,
  });

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    return Category(
      name: snapshot['name'] as String,
      imageURL: snapshot['imageURL'] as String,
      description: snapshot['description'] as String,
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceDetailPage(
                serviceData: servicesData,
                serviceKey: category.name,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(
                category.imageURL,
                width: 48.0,
                height: 48.0,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      category.description,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CategoryDetailPage extends StatelessWidget {
//   final Category category;

//   const CategoryDetailPage({Key? key, required this.category})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category.name),
//       ),
//       body: Center(
//         child: Text(
//           'Details of ${category.name}',
//           style: TextStyle(fontSize: 24.0),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class CategoryPage extends StatelessWidget {
//   final List<Category> categories = [
//     Category(
//       name: 'General Cleaning',
//       icon: Icons.clean_hands,
//       description:
//           'We provide professional cleaning services for residential and commercial spaces. Our team ensures thorough cleaning using eco-friendly products.',
//     ),
//     Category(
//       name: 'Appliance Repair',
//       icon: Icons.home_repair_service,
//       description:
//           'Get your appliances repaired by our expert technicians. We fix all kinds of appliances, including refrigerators, washing machines, and ovens.',
//     ),
//     Category(
//       name: 'Home Painting',
//       icon: Icons.brush_rounded,
//       description:
//           'Transform your home with our professional painting services. Choose from a wide range of colors and finishes to suit your style.',
//     ),
//     Category(
//       name: 'Pest Control',
//       icon: Icons.pest_control_rounded,
//       description:
//           'Say goodbye to pests with our effective pest control solutions. We eliminate pests such as ants, rodents, cockroaches, and bedbugs.',
//     ),
//     Category(
//       name: 'Salon & Spa',
//       icon: Icons.cut,
//       description:
//           'Indulge in relaxation and beauty treatments at our salon & spa. Our experienced staff offers a range of services including haircuts, massages, and facials.',
//     ),
//     Category(
//       name: 'Electrician',
//       icon: Icons.light_mode_rounded,
//       description:
//           'Get your maintaince of any electronics devices from our experience technicians',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.blueAccent, // Set primary color for the app
//         cardColor: Color.fromARGB(253, 255, 255, 255), // Set card color
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Categories',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.blue[100], // Set app bar color to blue
//         ),
//         body: ListView.builder(
//           itemCount: categories.length,
//           itemBuilder: (BuildContext context, int index) {
//             return CategoryCard(category: categories[index]);
//           },
//         ),
//       ),
//     );
//   }
// }

// class Category {
//   final String name;
//   final IconData icon;
//   final String description;

//   Category({required this.name, required this.icon, required this.description});
// }

// class CategoryCard extends StatelessWidget {
//   final Category category;

//   const CategoryCard({Key? key, required this.category}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       color: Theme.of(context).cardColor, // Use theme card color
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CategoryDetailPage(category: category),
//             ),
//           );
//         },
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Icon(category.icon, size: 48.0),
//               SizedBox(width: 16.0),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       category.name,
//                       style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       category.description,
//                       style: TextStyle(fontSize: 16.0, color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CategoryDetailPage extends StatelessWidget {
//   final Category category;

//   const CategoryDetailPage({Key? key, required this.category})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category.name),
//       ),
//       body: Center(
//         child: Text(
//           'Details of ${category.name}',
//           style: TextStyle(fontSize: 24.0),
//         ),
//       ),
//     );
//   }
// }



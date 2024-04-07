import 'package:flutter/material.dart';
// import '.././booking/booking_details.dart'; // Remove unused import
import '../pages/home.dart';
import '../components/nav.dart';
import '../pages/technicianAssignment.dart';

class ServiceDetailPage extends StatelessWidget {
  final Map<String, dynamic> serviceData;
  final String serviceKey;

  const ServiceDetailPage({
    required this.serviceData,
    required this.serviceKey,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> service = serviceData[serviceKey];

    if (service == null) {
      // Handle the case where the service key is not found in the map
      return Scaffold(
        appBar: AppBar(
          title: const Text('Service Not Found'),
        ),
        body: const Center(
          child: Text('The requested service is not available.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(service['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(service['banner']),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   'Category: ${service['category']}', // Commented out, might not be needed
                  //   style: const TextStyle(fontSize: 18),
                  // ),
                  // const SizedBox(height: 8),
                  Text(
                    'Price: \$${service['price'].toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Ratings: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        service['ratings'].toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'About:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    'Photos:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: (service['photos'] as List<String>)
                          .map((photo) => GestureDetector(
                                onTap: () {
                                  // Implement photo enlargement
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    photo,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TechnicianDetailPage(
                                selectedCategories: [
                                  serviceKey
                                ], // Assuming TechnicianDetailPage uses categories
                              ),
                            ),
                          );
                        },
                        child: const Text('Book Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

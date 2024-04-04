import 'package:flutter/material.dart';
// import '.././booking/booking_details.dart';
import '../pages/home.dart';
import '../pages/nav.dart';

class ServiceDetailPage extends StatelessWidget {
  final List<Map<String, dynamic>> serviceData;
  final int index;

  const ServiceDetailPage({
    required this.serviceData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> service = serviceData[index];
    print(service);

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
                  Text(
                    'Category: ${service['category']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
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
                      children:
                          (service['photos'] as List<String>).map((photo) {
                        return GestureDetector(
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
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement message button functionality
                        },
                        child: const Text('Message'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Implement book now button functionality
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
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

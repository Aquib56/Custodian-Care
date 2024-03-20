import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<ServiceItem> selectedServices = []; // List to hold selected services

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Selected Services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // Display selected services with quantity adjustment
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedServices.length,
                itemBuilder: (context, index) {
                  return ServiceListItem(
                    serviceItem: selectedServices[index],
                    onIncrement: () {
                      setState(() {
                        selectedServices[index].quantity++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        if (selectedServices[index].quantity > 1) {
                          selectedServices[index].quantity--;
                        }
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 16),
              // Date and time picker
              Text(
                'Pick Date and Time',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Implement date and time picker widget here
              SizedBox(height: 16),
              // Promo code section
              Text(
                'Apply Promo Code',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Implement promo code input field here
              SizedBox(height: 16),
              // Total price and continue button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price: \$${calculateTotalPrice()}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement continue button functionality
                    },
                    child: Text('Continue'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Calculate total price based on selected services
  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var service in selectedServices) {
      totalPrice += service.quantity * service.price;
    }
    return totalPrice;
  }
}

class ServiceItem {
  final String title;
  final double price;
  int quantity;

  ServiceItem({
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}

class ServiceListItem extends StatelessWidget {
  final ServiceItem serviceItem;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const ServiceListItem({
    required this.serviceItem,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${serviceItem.title} (\$${serviceItem.price.toStringAsFixed(2)})'),
        Row(
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: Icon(Icons.remove),
            ),
            Text(serviceItem.quantity.toString()),
            IconButton(
              onPressed: onIncrement,
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

final Map<String, Map<String, dynamic>> servicesData = {
  "Plumber": {
    "imagePath": "assets/cleaningService.jpeg",
    "banner": "assets/cleaningService.jpeg",
    "title": "Cleaning",
    "price": 100.0,
    "ratings": 4.5,
    "description":
        "Customers can easily book a Cleaning service through the app by specifying their requirements such as the type of Cleaning needed",
    "photos": ["assets/cleaningService.jpeg", "assets/cleaningService1.jpeg"]
  },
  "Painting": {
    "imagePath": "assets/cleaningService.jpeg",
    "title": "Plumber",
    "banner": "assets/cleaningService.jpeg",
    "price": 100.0,
    "ratings": 4.5,
    "description":
        "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
    "photos": ["assets/cleaningService.jpeg", "assets/cleaningService1.jpeg"]
  },
  "Electrician": {
    // Data assumed for Electrician (replace with actual data if available)
    "imagePath": "assets/electrician.png",
    "title": "Electrician",
    "banner":
        "Electrician banner image (replace)", // Replace with appropriate banner image path
    "price": 150.0, // Adjust price accordingly
    "ratings": 4.8, // Adjust ratings accordingly
    "description":
        "Customers can easily book an Electrician service through the app by specifying their requirements. Once booked, experienced electricians are dispatched to the customer's location at the scheduled time.",
    "photos": [
      "assets/electricianService.jpeg",
      "assets/electricianService.jpeg"
    ] // Replace or add photos if needed
  },
  "Hairdresser": {
    // Data assumed for Hairdresser (replace with actual data if available)
    "imagePath": "assets/hairdresser.png",
    "title": "Hairdresser",
    "banner":
        "Hairdresser banner image (replace)", // Replace with appropriate banner image path
    "price": 120.0, // Adjust price accordingly
    "ratings": 4.7, // Adjust ratings accordingly
    "description":
        "Customers can easily book a Hairdresser service through the app by specifying their requirements. Once booked, experienced hairdressers are dispatched to the customer's location at the scheduled time.",
    "photos": [
      "assets/banners/sampleJob1.jpg",
      "assets/banners/sampleJob1.jpg"
    ] // Replace or add photos if needed
  },
  "Gardener": {
    // Data assumed for Gardener (replace with actual data if available)
    "imagePath":
        "assets/gardener.png", // Replace with gardener image if available
    "title": "Gardener",
    "banner":
        "Gardener banner image (replace)", // Replace with appropriate banner image path
    "price": 80.0, // Adjust price accordingly
    "ratings": 4.9, // Adjust ratings accordingly
    "description":
        "Customers can easily book a Gardener service through the app by specifying their requirements. Once booked, experienced gardeners are dispatched to the customer's location at the scheduled time.",
    "photos": [
      "assets/gardener_service_photos1.jpg",
      "assets/gardener_service_photos2.jpg"
    ] // Replace with gardener service photos if available
  }
};


// final List<Map<String, dynamic>> servicesData = [
//   {
//     'imagePath': 'assets/cleaningService.jpeg',
//     'banner': 'assets/cleaningService.jpeg',
//     'title': 'Cleaning',
//     'category': 'Plumber',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a Cleaning service through the app by specifying their requirements such as the type of Cleaning needed",
//     'photos': ['assets/cleaningService.jpeg', 'assets/cleaningService1.jpeg'],
//   },
//   {
//     'imagePath': 'assets/electricianService.jpeg',
//     'banner': 'assets/electricianService.jpeg',
//     'title': 'Cleaning',
//     'category': 'Plumber',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a Electrician service through the app by specifying their requirements such as the type of electrician needed",
//     'photos': [
//       'assets/electricianService.jpeg',
//       'assets/electricianService.jpeg'
//     ],
//   },
//   {
//     'imagePath': 'assets/PaintingService',
//     'title': 'Plumber',
//     'banner': 'assets/PaintingService.jpeg',
//     'category': 'Home Services',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
//     'photos': [
//       'assets/assets/PaintingService',
//       'assets/assets/PaintingService'
//     ],
//   },
//   {
//     'imagePath': 'assets/maid.png',
//     'title': 'Maid',
//     'banner': 'assets/haridresserService.jpeg',
//     'category': 'Home Services',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
//     'photos': [
//       'assets/banners/sampleJob1.jpg',
//       'assets/banners/sampleJob1.jpg'
//     ],
//   },
//   {
//     'imagePath': 'assets/hairdresser.png',
//     'title': 'Hair Care',
//     'banner': 'assets/banners/sampleJob1.jpg',
//     'category': 'Home Services',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
//     'photos': [
//       'assets/banners/sampleJob1.jpg',
//       'assets/banners/sampleJob1.jpg'
//     ],
//   },
//   {
//     'imagePath': 'assets/pest-control.png',
//     'title': 'Pest Control',
//     'banner': 'assets/banners/sampleJob1.jpg',
//     'category': 'Home Services',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
//     'photos': [
//       'assets/banners/sampleJob1.jpg',
//       'assets/banners/sampleJob1.jpg'
//     ],
//   },
//   {
//     'imagePath': 'assets/teacher.png',
//     'title': 'Tutions',
//     'banner': 'assets/banners/sampleJob1.jpg',
//     'category': 'Home Services',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
//     'photos': [
//       'assets/banners/sampleJob1.jpg',
//       'assets/banners/sampleJob1.jpg'
//     ],
//   },
//   {
//     'imagePath': 'assets/electrician.png',
//     'title': 'Electrician',
//     'banner': 'assets/banners/sampleJob1.jpg',
//     'category': 'Home Services',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
//     'photos': [
//       'assets/banners/sampleJob1.jpg',
//       'assets/banners/sampleJob1.jpg'
//     ],
//   },
//   {
//     'imagePath': 'assets/plumber.png',
//     'title': 'Plumbing',
//     'banner': 'assets/banners/sampleJob1.jpg',
//     'category': 'Home Services',
//     'price': 100.0,
//     'ratings': 4.5,
//     'description':
//         "Customers can easily book a painting service through the app by specifying their requirements such as the type of painting needed, the size of the area to be painted, preferred colors, and any additional preferences they may have. Once booked, experienced painters are dispatched to the customer's location at the scheduled time.",
//     'photos': [
//       'assets/banners/sampleJob1.jpg',
//       'assets/banners/sampleJob1.jpg'
//     ],
//   },
// ];

// final List<Map<String, dynamic>> categoriesMap = [
//   {'imagePath': 'assets/img1.png', 'title': 'Category 1'},
//   {'imagePath': 'assets/img1.png', 'title': 'Category 2'},
//   {'imagePath': 'assets/img1.png', 'title': 'Category 3'},
//   // Add more categories as needed
// ];


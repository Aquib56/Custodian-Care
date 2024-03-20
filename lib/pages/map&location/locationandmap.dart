// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class AddressSelectionPage extends StatefulWidget {
//   @override
//   _AddressSelectionPageState createState() => _AddressSelectionPageState();
// }
//
// class _AddressSelectionPageState extends State<AddressSelectionPage> {
//   GoogleMapController mapController;
//   LocationData currentLocation;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     var location = Location();
//     currentLocation = await location.getLocation();
//     setState(() {});
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Address'),
//       ),
//       body: currentLocation == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(currentLocation.latitude, currentLocation.longitude),
//           zoom: 15.0,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('userLocation'),
//             position: LatLng(currentLocation.latitude, currentLocation.longitude),
//           ),
//         },
//         onTap: (LatLng latLng) {
//           // Handle tap on map
//           // You can add logic to add a marker at the tapped location
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle address confirmation and storing in Firestore
//           Navigator.pop(context); // Navigate back to booking details page
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }

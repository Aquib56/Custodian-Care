import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler package

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();
  late String selectedAddress;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(); // Request location permission when the page initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              _getCurrentLocation();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194), // San Francisco coordinates
              zoom: 12,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onCameraMove: (position) {
              _updateSelectedAddress(position.target);
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search location...',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // You can use this callback to update search results as the user types
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchLocation();
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 105,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Handle saving the selected address and continue
                _saveSelectedAddress();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Custom button color
                elevation: 5, // Shadow depth
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Custom border radius
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15), // Custom padding
              ),
              child: const Text(
                'Select this address and continue',
                style: TextStyle(fontSize: 18), // Custom text style
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        ),
      ),
    );
    _updateSelectedAddress(LatLng(position.latitude, position.longitude));
  }

  void _updateSelectedAddress(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      setState(() {
        selectedAddress =
            '${placemarks.first.name}, ${placemarks.first.subLocality}, ${placemarks.first.locality}';
        // You can update your UI with the selected address here
      });
    }
  }

  void _searchLocation() async {
    String query = searchController.text;
    List<Location> locations = await locationFromAddress(query);
    if (locations != null && locations.isNotEmpty) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(locations.first.latitude, locations.first.longitude),
            zoom: 15,
          ),
        ),
      );
      _updateSelectedAddress(
          LatLng(locations.first.latitude, locations.first.longitude));
    }
  }

  Future<void> _requestLocationPermission() async {
    if (await Permission.location.isGranted) {
      // Location permission is already granted
      _getCurrentLocation();
    } else {
      // Location permission is not granted, request it
      final permissionStatus = await Permission.location.request();
      if (permissionStatus == PermissionStatus.granted) {
        // Permission granted, get the current location
        _getCurrentLocation();
      } else {
        // Permission denied, handle accordingly
        print('Location permission denied');
      }
    }
  }

  void _saveSelectedAddress() {
    // You can implement saving the selected address and continuing here
    // For example, you can use Navigator to pop this page and pass the selected address back to the previous page
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();
  late String selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
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
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search location...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchLocation();
                    },
                  ),
                ),
                onChanged: (value) {
                  // You can use this callback to update search results as the user types
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Handle saving the selected address and continue
                _saveSelectedAddress();
              },
              child: Text('Select this address and continue'),
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

  void _saveSelectedAddress() {
    // You can implement saving the selected address and continuing here
    // For example, you can use Navigator to pop this page and pass the selected address back to the previous page
  }
}

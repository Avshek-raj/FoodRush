import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late LatLng _center;
  late LocationData _currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    loc.Location location = loc.Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();
    setState(() {
      _center = LatLng(_currentLocation.latitude!, _currentLocation.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Location'),
      ),
      body: _center == null
          ? Center(child: CircularProgressIndicator())
          : Container(
            child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
            mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
                    ),
                    onTap: (LatLng latLng) {
            print(latLng); // Handle tapped location
                    },
                  ),
          ),
    );
  }
}

Future<String> getAddressFromLatLng(LatLng latLng) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      return placemark.locality.toString() ??  placemark.subAdministrativeArea.toString() ;
      // You can access other details like placemark.locality, placemark.country, etc.
    } else {
      return "Address not found";
    }
  } catch (e) {
    print("Error: $e");
    return "Error fetching address";
  }
}


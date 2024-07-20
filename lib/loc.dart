import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sycet_attendance/noti.dart';
import 'package:sycet_attendance/scann_fingerprint.dart';
import 'package:permission_handler/permission_handler.dart';

import 'loc_error.dart';

class homescreen extends StatefulWidget {
  @override
  _homescreenState createState() => _homescreenState();
}

class lab_123_B1 {
  double latitude = 19.8181851;
  double longitude = 75.3307538;
}

class _homescreenState extends State<homescreen> {
  String _locationMessage = '';
  final NotificationService notificationService = NotificationService();
  bool isWithinRadius = false;
  bool isLoading = true; // State variable for showing/hiding loader
  lab_123_B1 lab_123_b1 = lab_123_B1();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get the current location
  void _getCurrentLocation() async {
    // Request location permission
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, proceed with getting the location
      final double targetRadius = 500.5; // Radius in meters
      setState(() {
        isLoading = true; // Show loader when fetching location
      });
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double distanceInMeters = await Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          lab_123_b1.latitude,
          lab_123_b1.longitude,
        );
        setState(() {
          isLoading = false; // Hide loader after fetching location
          if (distanceInMeters <= targetRadius) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationScreen()));
            //this space i want call notification function
            notificationService.scheduleImmediateNotification();
          }
        });
      } catch (e) {
        print(e);
        setState(() {
          _locationMessage = 'Error getting location';
          isLoading = false; // Hide loader if there's an error
        });
      }
    } else {
      // Permission denied
      setState(() {
        _locationMessage = 'Location permission denied';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.location_on,
              size: 100.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Getting your Current Location',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              _locationMessage,
              style:const TextStyle(
                fontSize: 18.0,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: isLoading ? null : _getCurrentLocation, // Disable button while loading
              child: isLoading
                  ? const CircularProgressIndicator() // Show loader while loading
                  :const Text(''),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: homescreen(),
));

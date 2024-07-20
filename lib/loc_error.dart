import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as Math;
import 'package:sycet_attendance/scann_fingerprint.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2 - lat1);
  var dLon = deg2rad(lon2 - lon1);
  var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(deg2rad(lat1)) *
          Math.cos(deg2rad(lat2)) *
          Math.sin(dLon / 2) *
          Math.sin(dLon / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c; // Distance in km
  return d;
}

double deg2rad(deg) {
  return deg * (Math.pi / 180);
}

class lab_123_B1 {
  double latitude = 19.8192285;
  double longitude = 75.2964779;
  String name = "";
}

class _LocationScreenState extends State<LocationScreen> {
  String _locationMessage = '';
  String _locationMessage2 = '';
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
    final double targetRadius = 1000.5; // Radius in meters
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
      lab_123_b1.name = 'Suket';
      setState(() {
        double distance_km = getDistanceFromLatLonInKm(position.latitude,
            position.longitude, lab_123_b1.latitude, lab_123_b1.longitude);
        distance_km = distance_km * 1000;
        _locationMessage2 =
            "Distance between approximately $distance_km meter.";
        _locationMessage =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        isLoading = false; // Hide loader after fetching location
        if (distanceInMeters <= targetRadius) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AuthScreen()));
        }
      });
      print(distanceInMeters);
    } catch (e) {
      print(e);
      setState(() {
        _locationMessage = 'Error getting location';
        isLoading = false; // Hide loader if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 48.0,
              color: Colors.blue,
            ),
            SizedBox(height: 10.0),
            Text(
              'Your current location is:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              _locationMessage,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              _locationMessage2,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : _getCurrentLocation, // Disable button while loading
              child: isLoading
                  ? CircularProgressIndicator() // Show loader while loading
                  : Text('Get Current Location'),
            ),
            // ElevatedButton(onPressed: (){_saveData('Suket');}, child: Text('Save Name')),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

// void main() => runApp(MaterialApp(
//   home: LocationScreen(),
// ));

//previous code...
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:math' as Math;
//
// import 'package:location/scann_fingerprint.dart';
//
// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }
//
// double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
//   var R = 6371; // Radius of the earth in km
//   var dLat = deg2rad(lat2 - lat1);
//   var dLon = deg2rad(lon2 - lon1);
//   var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
//       Math.cos(deg2rad(lat1)) *
//           Math.cos(deg2rad(lat2)) *
//           Math.sin(dLon / 2) *
//           Math.sin(dLon / 2);
//   var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
//   var d = R * c; // Distance in km
//   return d;
// }
//
// double deg2rad(deg) {
//   return deg * (Math.pi / 180);
// }
// class lab_123_B1{
//   double latitude = 19.821586;
//   double longitude = 75.2925642;
// }
// class _LocationScreenState extends State<LocationScreen> {
//   final double targetRadius = 2.5; // Radius in meters
//   String _locationMessage = '';
//   String _locationMessage2 = '';
//   bool isWithinRadius = false;
//
//   lab_123_B1 lab_123_b1 = lab_123_B1();
//   // Get the current location
//   void _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       double distanceInMeters = await Geolocator.distanceBetween(
//         position.latitude,
//         position.longitude,
//         lab_123_b1.latitude,
//         lab_123_b1.longitude,
//       );
//       setState(() {
//         double distance_km = getDistanceFromLatLonInKm(position.latitude, position.longitude, lab_123_b1.latitude, lab_123_b1.longitude);
//         distance_km = distance_km * 1000;
//         _locationMessage2 ="Distance between approximately $distance_km meter.";
//         _locationMessage = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
//       });
//       print(distanceInMeters);
//       if(distanceInMeters <= targetRadius ){
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         _locationMessage = 'Error getting location';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               Icons.location_on,
//               size: 48.0,
//               color: Colors.blue,
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               'Your current location is:',
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 5.0),
//             Text(
//               _locationMessage,
//               style: TextStyle(
//                 fontSize: 18.0,
//               ),
//             ),
//             SizedBox(height: 5.0),
//             Text(
//               _locationMessage2,
//               style: TextStyle(
//                 fontSize: 18.0,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             ElevatedButton(
//               onPressed: () {
//                 _getCurrentLocation();
//               },
//               child: Text('Get Current Location'),
//             ),
//             SizedBox(height: 10.0),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() => runApp(MaterialApp(
//   home: LocationScreen(),
// ));

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sycet_attendance/login2.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> delete_user() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    prefs2.remove('username');
    SharedPreferences prefs3 = await SharedPreferences.getInstance();
    prefs3.remove('rollno');
  }

  String? _savedData;
  String? _savedroll;
// RETRIVE STORED DATA.
  Future<void> _retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedData = prefs.getString('username') ?? 'No data saved yet!';
      _savedroll = prefs.getString('rollno') ?? ' ';
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          const Center(child: Text('Logout')),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              delete_user();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Center(  // Added Center widget to center the Stack
        child: Stack(
          children: [
            Positioned(
              top: 0,  // Adjusted top position to be below the first Positioned widget
              left: 0,  // Adjusted left position
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width-20,  // Adjusted width to fit the screen
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 95,  // Adjusted top position
              left: MediaQuery.of(context).size.width/2.8,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                  color: Colors.white, // Background color of the circle
                ),
                padding: EdgeInsets.all(8), // Adjust padding as needed
                child: Icon(Icons.person, color: Colors.blue, size: 100), // Icon widget
              ),
            ),
            Positioned(
                top: 220,
                left: 10,
                child: Column(
              children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('UserID : ' + _savedData.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('Rollno : ' + _savedroll.toString()+'                                             ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('Class : TE CSE                                           ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

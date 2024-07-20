import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sycet_attendance/home.dart';
import 'package:sycet_attendance/pdf_screen.dart';
import 'package:sycet_attendance/profile.dart';


class SideMenuBar extends StatefulWidget {
  @override
  SideMenuBarState createState() => SideMenuBarState();
}
class SideMenuBarState extends State<SideMenuBar> {

  String? _savedData;
  String? _savedroll;

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedData = prefs.getString('username') ?? 'null';
      _savedroll = prefs.getString('rollno') ?? 'null';
    });
  }
  void initState(){
    super.initState();
    getUser();
  }

  @override
Widget build(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.white, // Background color of the circle
                ),
                padding: EdgeInsets.all(8), // Adjust padding as needed
                child: Icon(Icons.person, color: Colors.blue, size: 28), // Icon widget
              ),

              SizedBox(height: 15),
              Text(_savedroll.toString(),
                style:const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),// Add some space between icon and text
              SizedBox(height: 5),
              GestureDetector(onTap: () {
                // Navigate to the new page when the first text is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      _savedData.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  const Text(
                      '>',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                ],
              ),
    ),

    ],
          ),
        ),
        ListTile(
          title: Text('Profile'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
          },
        ),
        ListTile(
          title: const Text('Syllabus'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> PDFViewerPage()));
          },
        ),
        Divider(),
      ],
    ),
  );
}
}


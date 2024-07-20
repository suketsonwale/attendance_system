import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sycet_attendance/SideMenuBar.dart';
import 'package:sycet_attendance/atd_data.dart';
import 'package:sycet_attendance/defaultScreen.dart';
import 'package:sycet_attendance/loc.dart';

//main page
class Home2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue,
      ),
      drawer: SideMenuBar(),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Wrap(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the new page when the first text is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => homescreen()),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 2), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            spreadRadius: 0.5, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(5, 5), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Attendance',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the new page when the first text is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AtdData()),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 2), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            spreadRadius: 0.5, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(5, 5), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'View Attendance ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'History ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the new page when the first text is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DefaultScreen(title: 'Defaulter')),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 2), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            spreadRadius: 0.5, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(5, 5), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Defaulter',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the new page when the first text is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DefaultScreen(title: 'Daily Progress')),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 2), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            spreadRadius: 0.5, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(5, 5), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Daily',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Progress',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the new page when the first text is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DefaultScreen(title: 'Apply Leave')),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 2), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            spreadRadius: 0.5, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(5, 5), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Apply',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Leave',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the new page when the first text is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DefaultScreen(
                                title: 'Request Miss Attendance')),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 2), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            spreadRadius: 0.5, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(5, 5), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Request Miss',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Attendance',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

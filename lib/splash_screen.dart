import 'package:flutter/material.dart';
import 'package:sycet_attendance/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4), () {
      // Navigate to the main screen (Replace 'MainScreen()' with your main screen widget)
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home2()));
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3a57e8),
      body: Stack(
        children: [
          Positioned(
              child: Image.asset('assets/atd1.png', height: 400,)),
          Padding(padding: EdgeInsets.fromLTRB(120, 350, 80, 0),
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              Column(
                children: [
                  Text(
                    'Attendify',
                    style: TextStyle(
                      fontSize: 40,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 8
                        ..color = Colors.green,
                    ),
                  ),
                ],
              ),
              // Solid text as fill.
              const Column(
                children: [
                  Text(
                    'Attendify',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),),

          Positioned(
              top: 460,
              left: 15,
              child: Text('-----------------------------  Easy Attendance  ------------------------------',style: TextStyle(color: Colors.white),)),
          const Positioned(
            top: 580,
              left: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                    child: Text('Created By:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      Text('1. Suket Sonwale.          ', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                      Text('2. Chetan Suryawanshi.', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                    ],
                  ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(45, 100, 0, 0),
                  child: Row(
                    children: [
                      Icon(IconData(0xe198, fontFamily: 'MaterialIcons'),color: Colors.white54,),
                      Text(' All rights are reserved. Version 1.0.0. . 2024',style: TextStyle(color: Colors.white54),),
                    ],
                  ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

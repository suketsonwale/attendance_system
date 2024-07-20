import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';           // storage
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sycet_attendance/home.dart';
import 'package:sycet_attendance/sign_in.dart';
import 'package:flutter/services.dart';
import 'package:sycet_attendance/splash_screen.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          // Exit the app when back button is pressed
          SystemNavigator.pop();
          return true;
        },
        child: Loginpage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}
class _LoginpageState extends State<Loginpage> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true; // Initially hide the password
  String message = '';
  Future<void> registerUser() async {
    await dotenv.load();
    String apiKey = dotenv.env['API_KEY_LOGIN'] ?? '';

    final apiUrl = Uri.parse('https://takshyantra.sypoly.org/login_api.php');
    final Map<String, String> requestData = {
      'user_id': userIdController.text,
      'password': passwordController.text,
    };
    final http.Response response = await http.post(
      apiUrl,
      headers: <String, String>{
        'API_KEY': apiKey,
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        message = responseData['message'];
      });
      if (message == 'Login Successfully') {
        String? _savedData;
        String? _savedroll;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        SharedPreferences prefs3 = await SharedPreferences.getInstance();
        setState(() {
          _savedData = prefs.getString('username') ?? 'null';
          _savedroll = prefs3.getString('rollno') ?? 'null';
        });
        if(_savedData == 'null') {
          SharedPreferences prefs2 = await SharedPreferences.getInstance();
          await prefs2.setString('username', userIdController.text);
        }
        if(_savedroll == 'null') {
          SharedPreferences prefs4 = await SharedPreferences.getInstance();
          await prefs4.setString('rollno', responseData['roll_no'].toString());
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home2()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } else {
      setState(() {
        message = 'Failed to Login.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

// RETRIVE STORED DATA.
  Future<void> _retrieveData() async {
    String? _savedData;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedData = prefs.getString('username');
    if(_savedData != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home2()),
      );
    }
  }

  void initState(){
    super.initState();
    _retrieveData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3a57e8),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: NetworkImage(
                        "https://cdn3.iconfinder.com/data/icons/spring-23/32/butterfly-spring-insect-monarch-serenity-moth-flutter-128.png"),
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 16),
                  child: TextField(
                    controller: userIdController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style:const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xffffffff),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0xffffffff),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0xffffffff),
                          width: 2,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0xffffffff),
                          width: 2,
                        ),
                      ),
                      labelText: "USERNAME",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xffffd261),
                      ),
                      hintText: "Enter email-id",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.cyan,
                      ),
                      filled: true,
                      fillColor: Color(0x00ffffff),
                      isDense: false,
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: _obscureText, // Set the obscureText property
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xffffffff),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Color(0xffffffff),
                        width: 2,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Color(0xffffffff),
                        width: 2,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:const BorderSide(
                        color: Color(0xffffffff),
                        width: 2,
                      ),
                    ),
                    labelText: "PASSWORD",
                    labelStyle:const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xffffd261),
                    ),
                    hintText: "Enter password",
                    hintStyle:const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Colors.cyan,
                    ),
                    filled: true,
                    fillColor: Color(0x00ffffff),
                    isDense: false,
                    contentPadding: EdgeInsets.all(0),
                    // Add the suffixIcon for the toggle button
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Toggle the visibility of the password
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      // Use Icons.visibility and Icons.visibility_off for the toggle button
                      icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),

               const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Forgot Password ?",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xffffd261),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    registerUser();
                  },
                  color: Color(0xffffd261),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding:const EdgeInsets.all(16),
                  textColor:const Color(0xff575454),
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width,
                  child:const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
               const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "OR",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Signin()));
                    }, child: Text('Create Account?', style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

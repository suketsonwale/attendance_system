import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';           // storage
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sycet_attendance/home.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sycet_attendance/login2.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Signinpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Signinpage extends StatefulWidget {
  @override
  _SigninpageState createState() => _SigninpageState();
}
class _SigninpageState extends State<Signinpage> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  bool _obscureText = true; // Initially hide the password
  String message = '';

  String? _savedData;
  String? _saveroll;

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _savedData = prefs.getString('username');
    _saveroll = prefs.getString('rollno');

    // If username is null, save the entered username
    if (_savedData == null && userIdController.text.isNotEmpty) {
      await prefs.setString('username', userIdController.text);
      _savedData = userIdController.text;
    }

    // If rollno is null, save the entered rollno
    if (_saveroll == null && rollNoController.text.isNotEmpty) {
      await prefs.setString('rollno', rollNoController.text);
      _saveroll = rollNoController.text;
    }

    setState(() {});
  }

  Future<void> registerUser() async {
    await dotenv.load();
    String apiKey = dotenv.env['API_KEY_SIGN_IN'] ?? '';

    final apiUrl = Uri.parse('https://takshyantra.sypoly.org/signin_api.php');
    final Map<String, String> requestData = {
      'user_id': userIdController.text,
      'password': passwordController.text,
      'name': nameController.text,
      'rollno': rollNoController.text,
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
      if (message == 'Signup Successfully') {
        saveUserData();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),);
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
        message = 'Failed to SignUp.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

// RETRIVE STORED DATA.
//   Future<void> _retrieveData() async {
//     String? _savedData;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _savedData = prefs.getString('username');
//     if(_savedData != null){
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home2()),
//       );
//     }
//   }

  void initState(){
    super.initState();
    // _retrieveData();
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
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: nameController,
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
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xffffd261),
                      ),
                      hintText: "Enter Your Full Name",
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
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: rollNoController,
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
                      labelText: "Roll No",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xffffd261),
                      ),
                      hintText: "Enter Roll No.",
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
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
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
                const SizedBox(width : 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(
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
                      "Signup",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
                Padding(padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                    // Navigator.of(context).pop();
                  }, child: Text('Already have an Account?',style: TextStyle(color: Colors.cyanAccent),)),
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

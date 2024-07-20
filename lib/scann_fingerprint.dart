import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; //storage

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum SupportState {
  unknown,
  supported,
  unSupported,
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;

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
    _retrieveData();
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
        supportState =
            isSupported ? SupportState.supported : SupportState.unSupported));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
    authenticateWithBiometrics();
  }

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("Biometric supported: $canCheckBiometric");
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print("supported biometrics $biometricTypes");
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      availableBiometrics = biometricTypes;
    });
  }

  var message;
  bool update = false;
  Future<void> updateDate() async {
    await dotenv.load();
    String apiKey = dotenv.env['API_KEY_ADD_ATD'] ?? '';

    final apiUrl = Uri.parse('https://takshyantra.sypoly.org/atd_api.php');
    final Map<String, String> requestData = {
      'rollno': _savedroll.toString(),
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
      if (message == 'Attendance Updated') {
        update = true;
      } else {
        update = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } else {
      setState(() {
        message = 'Failed to add Attendance.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason:
              'Authenticate with fingerprint or Face ID to add your attendance',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));

      if (!mounted) {
        return;
      }

      if (authenticated) {
        updateDate();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attendance added Successfully')),
        );
        Navigator.of(context).pop();
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _savedData ?? 'Loading...',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            Text(
              supportState == SupportState.supported
                  ? "Click the below button to add today's attendance"
                  : supportState == SupportState.unSupported
                      ? 'Biometric authentication is not supported on this device'
                      : 'Checking biometric support...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: supportState == SupportState.supported
                    ? Colors.green
                    : supportState == SupportState.unSupported
                        ? Colors.red
                        : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            // Text('Supported biometrics : $availableBiometrics'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    authenticateWithBiometrics();
                  },
                  child: const Text("Authenticate with Fingerprint"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

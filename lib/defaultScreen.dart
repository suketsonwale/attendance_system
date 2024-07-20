import 'package:flutter/material.dart';
class DefaultScreen extends StatefulWidget {
  DefaultScreen({required this.title,super.key});
  var title;

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: Image.asset('assets/atd2.png',)),
            const Padding(padding: EdgeInsets.all(0.0),
            child: Text('Currently this feature is in progress...',style: TextStyle(fontWeight: FontWeight.bold),),),

          ],
        ),
      ),
    );
  }
}

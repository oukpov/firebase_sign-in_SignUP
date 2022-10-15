import 'package:flutter/material.dart';

class LogingScreen extends StatelessWidget {
  const LogingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text('Loging'),
          )
        ],
      ),
    );
  }
}
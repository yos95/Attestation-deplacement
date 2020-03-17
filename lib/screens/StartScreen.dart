import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'AttestationScreen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    attestationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false

      backgroundColor: Colors.white.withOpacity(0.92),
      body: Stack(
        children: <Widget>[
          attestationScreen(),
        ],
      ),
    );
  }
}

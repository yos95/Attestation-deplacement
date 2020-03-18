import 'package:flutter/material.dart';

import '../screens/StartScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginWithDb();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white70,
            gradient:
                LinearGradient(colors: [Color(0xFF50BEE4), Color(0xFFAB3A85)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Attestation de déplacement",
                style: TextStyle(
                  fontFamily: "OpenSans-Bold",
                  fontSize: 26,
                  color: Colors.white,
                )),
          ],
        ), /* add child content here */
      ),
    );
  }

  Future loginWithDb() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartScreen()),
      );
    });
  }
}

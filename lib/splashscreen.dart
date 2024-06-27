import 'dart:async';
import 'package:elderscareapp/welcome1.dart';
import 'package:flutter/material.dart';
import 'package:elderscareapp/home/sharedpreference.dart';
import 'package:elderscareapp/bottomtab/bottomtab.dart';
import 'package:elderscareapp/signup/signinsmll.dart';

class splash extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splash> {
  @override
  void initState() {
    super.initState();
    _startSplashScreenTimer();
  }

  void _startSplashScreenTimer() {
    Timer(Duration(seconds: 3), _navigateBasedOnLoginStatus);  // Reduced time for better UX
  }

  void _navigateBasedOnLoginStatus() async {
    bool isLoggedIn = await SharedPrefHelper.getLoginStatus();
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomTabBar()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => welcome()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/logoofelders.png", fit: BoxFit.cover),
      ),
    );
  }
}

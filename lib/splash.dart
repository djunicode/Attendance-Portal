import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:attendance_portal/Auth/log.dart';
import 'package:attendance_portal/HomePage.dart';
import 'package:attendance_portal/Screens/Home/home.dart';
import 'package:attendance_portal/main.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: AnimatedSplashScreen(
            splash: 'assets/images/dj sanghvi logo.png',
            splashIconSize: 100,
            nextScreen: HomePage(),
            splashTransition: SplashTransition.slideTransition,
            backgroundColor: Colors.white,
            duration: 1000,
          ),
        ),
      ),
    );
  }
}
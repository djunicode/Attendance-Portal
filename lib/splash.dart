import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';

import 'log.dart';

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
            nextScreen: Log(),
            splashTransition: SplashTransition.slideTransition,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
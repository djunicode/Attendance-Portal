import 'package:attendance_portal/Utils.dart';
import 'package:attendance_portal/home.dart';
import 'package:attendance_portal/splash.dart';
import 'package:flutter/material.dart';

import 'log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: messengerKey,
    );
  }
}
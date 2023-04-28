import 'dart:async';
import 'package:attendance_portal/Screens/BottomNav.dart';
import 'package:attendance_portal/Auth/log.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tokens = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFlagValuesSF(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData && snapshot.data![0] == null) {
          return Log();
        } else if (snapshot.hasData) {
          if (snapshot.data![0]) {
            return BottomNav(
              refreshToken: snapshot.data![2],
              accessToken: snapshot.data![1],
            );
          } else {
            return Log();
          }
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text("Error occured"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<List<dynamic>?> getFlagValuesSF() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('flag');
    String? accessToken = prefs.getString('accessToken');
    String? refreshToken = prefs.getString('refreshToken');
    List<dynamic> list = [boolValue, accessToken, refreshToken];
    print(boolValue);
    return list;
  } catch (e) {
    print(e.toString());
  }
}

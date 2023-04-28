import 'dart:async';
import 'dart:convert';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Calendar/Calendar.dart';
import 'Profile/ProfilePage.dart';
import '../Models/Utils.dart';
import 'Home/home.dart';
import 'package:http/http.dart' as http;

Timer? _rootTimer;

class BottomNav extends StatefulWidget {
  String? refreshToken;
  String? accessToken;
  BottomNav({Key? key, required this.accessToken, required this.refreshToken})
      : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var tokens = [];

  void initializeTimer() {
    const time = Duration(seconds: 10);
    _rootTimer = Timer.periodic(time, (timer) async {
      var prefs = await SharedPreferences.getInstance();
      tokens = await refreshLogin(tokens[0]);

      if (tokens[0] == null) {
        Utils.showSnackBar(tokens[1]);
        _rootTimer?.cancel();
      } else {
        prefs.setString('accessToken', tokens[0]);
        Utils.showSnackBar1("Token refreshed!");
      }
    });
  }

  int groupValue = 0;
  List<IconData> iconList = [
    Icons.home,
    Icons.calendar_month_sharp,
    Icons.person,
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tokens = [widget.refreshToken, widget.accessToken];
    initializeTimer();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Home(),
      Calendar(),
      ProfilePage(
        accessToken: widget.accessToken,
        refreshToken: widget.refreshToken,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AnimatedBottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          activeColor: Color(0xff0056D2),
          inactiveColor: Colors.grey,
          icons: iconList,
          activeIndex: _selectedIndex,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (index) {
            setState(() {
              print(index);
              _selectedIndex = index;
            });
          },
          gapWidth: 3,
          //other params
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

Future<List<String?>> refreshLogin(String? refreshToken) async {
  String? token2, token3;
  var res = await http.post(
    Uri.parse(
        'http://attendanceportal.pythonanywhere.com/accounts/login/refresh/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"refresh": "$refreshToken"}),
  );
  print(res.body);
  Map data = jsonDecode(res.body);
  token2 = data['access'];
  token3 = data['detail'];
  var list = [token2, token3];
  print(list);
  return list;
}

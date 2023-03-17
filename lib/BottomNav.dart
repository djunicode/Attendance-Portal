import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Calendar.dart';
import 'ProfilePage.dart';
import 'home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(refreshToken: '', accessToken: '',),
    Calendar(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    List<IconData> iconList = [
      Icons.home,
      Icons.calendar_month_sharp,
      Icons.person,
    ];
    return  Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        activeColor: Color(0xff0056D2),
        inactiveColor: Colors.grey,
        icons: iconList,
        activeIndex: _selectedIndex,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) => setState(
                () => _selectedIndex = index
        ),
        iconSize:33,
        gapWidth:3,
        //other params
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

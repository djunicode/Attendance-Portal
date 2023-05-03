import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    bool absent = false;
    bool present = false;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.12,
        elevation: 0.7,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Column(
          children: [
            Text(
              "SE Comps",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  fontFamily: 'Montserrat'),
            ),
            Text(
              "Maths",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemCount: 50,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "60004210093",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              subtitle: Text(
                "Arya Shirgaonkar",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 13),
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    'assets/images/Blueclear.svg',
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xff0056D2), width: 2)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      absent = !absent;
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/images/RedClear.svg',
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xffD20000), width: 2)),
                ),
              ]),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 2,
          );
        },
      ),
    );
  }
}


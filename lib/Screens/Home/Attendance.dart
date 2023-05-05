import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/BatchDataAPI.dart';
import '../../Models/Utils.dart';

class Attendance extends StatefulWidget {
  List<BatchDataAPI>? details;
  int? lectureID;
  String? subjectName;
  String? batchName;

  Attendance(
      {Key? key,
      required this.details,
      required this.lectureID,
      required this.subjectName,
      required this.batchName})
      : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width - 16,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle),
                child: Center(
                    child: Text(
                  "Download",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        )
      ],
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
              widget.batchName!,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  fontFamily: 'Montserrat'),
            ),
            Text(
              widget.subjectName!,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemCount: widget.details!.length,
        itemBuilder: (BuildContext context, index) {
          return Tiles(
            details: widget.details,
            index: index,
            lectureID: widget.lectureID,
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

class Tiles extends StatefulWidget {
  bool absent = false;
  bool present = false;
  List<BatchDataAPI>? details;
  int? index;
  int? lectureID;

  Tiles(
      {Key? key,
      required this.details,
      required this.index,
      required this.lectureID})
      : super(key: key);

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.details![widget.index!].sapId.toString(),
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        subtitle: Text(
          widget.details![widget.index!].name,
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 13),
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  widget.present = !widget.present;
                  widget.absent = false;
                });
                await postAttendance(widget.present, widget.lectureID,
                    widget.details![widget.index!].id);
              },
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor:
                      widget.present ? Color(0xff0056D2) : Colors.white,
                  side: BorderSide(color: Color(0xff0056D2), width: 2)),
              child: widget.present
                  ? SvgPicture.asset(
                      'assets/images/whiteTick.svg',
                    )
                  : SvgPicture.asset(
                      'assets/images/Blueclear.svg',
                    )),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  widget.absent = !widget.absent;
                  widget.present = false;
                });
                await postAttendance(widget.present, widget.lectureID,
                    widget.details![widget.index!].id);
              },
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor:
                      widget.absent ? Color(0xffD20000) : Colors.white,
                  side: BorderSide(color: Color(0xffD20000), width: 2)),
              child: widget.absent
                  ? SvgPicture.asset(
                      'assets/images/whiteCross.svg',
                    )
                  : SvgPicture.asset(
                      'assets/images/RedClear.svg',
                    )),
        ]),
      ),
    );
  }
}

Future<String?> postAttendance(
    bool? present, int? lecture, int? student) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  print(accessToken);
  String? lecId;
  List dataOfLecs = [
    {"present": true, "lecture": 28, "student": 1},
    {"present": true, "lecture": 26, "student": 1},
    {"present": true, "lecture": 23, "student": 1},
  ];

  try {
    var res = await http.post(
      Uri.parse(
          'http://attendanceportal.pythonanywhere.com/attendance/lecture-attendance/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(
        dataOfLecs
      ),
    );
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 202) {
      Utils.showSnackBar("Attendance recorded");
    } else {
      Utils.showSnackBar1(res.reasonPhrase);
    }
    Map data = jsonDecode(res.body);
    print(data);
  } catch (e) {
    print(e.toString());
  }

  return lecId;
}

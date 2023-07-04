import 'dart:convert';
import 'dart:developer';
import 'package:attendance_portal/Models/AttendanceAPI.dart' as att;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../DownloadingDialog.dart';
import '../../Models/BatchDataAPI.dart';
import '../../Models/Utils.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'allCsvFileScreen.dart';
import 'loadCsvDataScreen.dart';

List<att.AttendanceAPI> dataOfAttendance = [];

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
        Container(
          height: 50,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff0056D2),
          ),
          child: InkWell(
            onTap: () async {
              // downloadAttendance(dataOfAttendance);
              // dataOfAttendance.map((e) => null);
              // print(dataOfAttendance.map((e) => e.student));
              // print(dataOfAttendance.map((e) => e.lecture));
              // print(dataOfAttendance.map((e) => e.present));
              //await postAttendance(dataOfAttendance);

              // showDialog(
              //     context: context,
              //     builder: (context)=> const DownloadingDialog(),);
              // print(dataOfAttendance[0].student);
              await downloadAttendance(dataOfAttendance);

            },
            borderRadius: BorderRadius.circular(10),
            child: const Center(
              child: Text(
                "Download",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
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

  Future downloadAttendance(List<att.AttendanceAPI>? attendanceList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    var res = await http.post(
      Uri.parse(
          'http://attendanceportal.pythonanywhere.com/attendance/mail-attendance/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{
        "lecture": "${attendanceList![0].lecture}",
      }),
    );
    print(res.statusCode);
    print(res.body);
    Map data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      Utils.showSnackBar1(data['message']);
    } else {
      Utils.showSnackBar(data['error']);
    }
    print(data);
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
                att.AttendanceAPI attendanceAPI = att.AttendanceAPI(
                    present: widget.present,
                    lecture: widget.lectureID!,
                    student: widget.details![widget.index!].sapId);
                log(attendanceAPI.student.toString());

                dataOfAttendance.add(attendanceAPI);
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

Future<String?> postAttendance(List<att.AttendanceAPI> dataOfAttendance) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  print(accessToken);
  String? lecId;
  log(dataOfAttendance.toString());

  try {
    var res = await http.post(
      Uri.parse(
          'http://attendanceportal.pythonanywhere.com/attendance/lecture-attendance/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(dataOfAttendance),
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


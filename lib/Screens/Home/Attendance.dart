import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/BatchDataAPI.dart';

class Attendance extends StatefulWidget {
  List<BatchDataAPI>? details;

  Attendance({Key? key, required this.details}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool absent = false;
  bool present = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

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
        itemCount: widget.details!.length,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.details![index].sapId.toString(),
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              subtitle: Text(
                widget.details![index].name,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 13),
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        present = !present;
                        absent = false;
                      });
                    },
                    child: present
                        ? SvgPicture.asset(
                            'assets/images/whiteTick.svg',
                          )
                        : SvgPicture.asset(
                            'assets/images/Blueclear.svg',
                          ),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor:
                            present ? Color(0xff0056D2) : Colors.white,
                        side: BorderSide(color: Color(0xff0056D2), width: 2))),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        absent = !absent;
                        present = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor:
                            absent ? Color(0xffD20000) : Colors.white,
                        side: BorderSide(color: Color(0xffD20000), width: 2)),
                    child: absent
                        ? SvgPicture.asset(
                            'assets/images/whiteCross.svg',
                          )
                        : SvgPicture.asset(
                            'assets/images/RedClear.svg',
                          )),
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

Future<List<BatchDataAPI>?> GetBatchDetails(
    String? accessToken, int? batchID) async {
  List<BatchDataAPI> x = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  print(accessToken);
  var res = await http.post(
    Uri.parse(
        'http://attendanceportal.pythonanywhere.com/attendance/batch-data/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, String>{'batch': batchID.toString()}),
  );
  print(res.body);
  print(res.statusCode);
  List<dynamic> data = jsonDecode(res.body);
  print(data);
  for (int i = 0; i < data.length; i++) {
    x.add(BatchDataAPI.fromJson(data[i]));
  }
  print(x);
  return x;
}

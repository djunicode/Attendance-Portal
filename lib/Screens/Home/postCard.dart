import 'dart:convert';

import 'package:attendance_portal/Models/Lecture.dart';
import 'package:attendance_portal/Models/getLectureDetails.dart';
import 'package:attendance_portal/Screens/Home/LectureDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'BatchDetails.dart';

class PostCard extends StatefulWidget {
  String? refreshToken;
  String? accessToken;

  PostCard({Key? key, required this.refreshToken, required this.accessToken})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return FutureBuilder(
      future: GetLectureDetails(widget.accessToken),
      builder: (context, snapshot) => snapshot.hasData
          ? SizedBox(
              height: height * 0.2,
              width: width * 0.88,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BatchDetails(),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFdedede), width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Batch: " + snapshot.data![0],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              snapshot.data![1] + " - " + snapshot.data![2],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: FloatingActionButton(
                                onPressed: () {},
                                child:
                                    SvgPicture.asset('assets/images/Clear.svg'),
                                backgroundColor: Color(0xff0056D2),
                                heroTag: UniqueKey(),
                              ),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            snapshot.data![3],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : !snapshot.hasError
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text("Error occured!"),
                ),
    );
  }
}

Future<List?> GetLectureDetails(String? accessToken) async {
  List<dynamic>? list;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  print(accessToken);
  var res = await http.get(
    Uri.parse(
        'http://attendanceportal.pythonanywhere.com/attendance/assigned-teacher-lecture'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    },
  );
  print(res.body);
  print(res.statusCode);
  Map<String, dynamic> data = jsonDecode(res.body);
  print(data);
  LectureAPI x = LectureAPI.fromJson(data);
  print(x.Lectures[0].subject.name);
  list = [
    x.Lectures[0].batch.name,
    x.Lectures[0].startTime,
    x.Lectures[0].endTime,
    x.Lectures[0].subject.name,
    x.Lectures[0].date,
  ];
  print(list);
  return list;
}

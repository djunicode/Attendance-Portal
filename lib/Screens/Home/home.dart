import 'dart:convert';
import 'package:attendance_portal/Screens/Home/BatchDetails.dart';
import 'package:attendance_portal/Screens/Home/CreateLectures.dart';
import 'package:attendance_portal/Screens/Home/postCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Models/getLectureDetails.dart';
import 'RangeAttendance.dart';

class Home extends StatefulWidget {
  String? refreshToken;
  String? accessToken;

  Home({Key? key, required this.accessToken, required this.refreshToken})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int groupValue = 0;
  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().add(Duration(days: 1));
    String formattedDate = DateFormat.MMMEd().format(now);
    print(formattedDate);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    final Map<int, Widget> lists = <int, Widget>{
      0: FutureBuilder<LectureAPI>(
        future: GetLectureDetails(widget.accessToken),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.Lectures.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 19, 239, 0.0),
                          child: Text(
                            snapshot.data!.Lectures[index].date,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )),
                      PostCard(
                        refreshToken: widget.refreshToken,
                        accessToken: widget.accessToken,
                        batch: snapshot.data!.Lectures[index].batch.name,
                        endTime: snapshot.data!.Lectures[index].endTime
                            .substring(0, 5),
                        startTime: snapshot.data!.Lectures[index].startTime
                            .substring(0, 5),
                        subject: snapshot.data!.Lectures[index].subject.name,
                        batchID: snapshot.data!.Lectures[index].batch.id,
                        batchName:
                            "Semester ${snapshot.data!.Lectures[index].batch.semester} Batch ${snapshot.data!.Lectures[index].batch.name}",
                        subjectName:
                            snapshot.data!.Lectures[index].subject.name,
                        lectureID: snapshot.data!.Lectures[index].id,
                      ),
                    ],
                  );
                })
            : !snapshot.hasError
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text("Error occured!"),
                  ),
      ),
      1: FutureBuilder<LectureAPI>(
        future: GetLectureDetails(widget.accessToken),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.Lectures.length,
                itemBuilder: (context, index) {
                  print(snapshot.data?.Lectures.length);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 19, 239, 0.0),
                        child: Text(snapshot.data!.Lectures[index].date,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      ),
                      PostCard(
                        refreshToken: widget.refreshToken,
                        accessToken: widget.accessToken,
                        batch: snapshot.data!.Lectures[index].batch.name,
                        endTime: snapshot.data!.Lectures[index].endTime
                            .substring(0, 5),
                        startTime: snapshot.data!.Lectures[index].startTime
                            .substring(0, 5),
                        subject: snapshot.data!.Lectures[index].subject.name,
                        batchID: snapshot.data!.Lectures[index].batch.id,
                        batchName:
                            "Semester ${snapshot.data!.Lectures[index].batch.semester} Batch ${snapshot.data!.Lectures[index].batch.name}",
                        subjectName:
                            snapshot.data!.Lectures[index].subject.name,
                        lectureID: snapshot.data!.Lectures[index].id,
                      ),
                    ],
                  );
                })
            : !snapshot.hasError
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text("Error occured!"),
                  ),
      )
    };

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.12,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Lectures",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: height * 0.045),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: height * 0.19,
                        width: width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    width * 0.21, 0, 0, 0.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.add_circle_outline),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                CreateLectures(),
                                          );
                                        },
                                        child: Text(
                                          "Create a lecture",
                                          style: TextStyle(
                                              fontSize: height * 0.024,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    width * 0.21, 0, 0, 0.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.people),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RangeAttendance()),
                                          );
                                        },
                                        child: Text("Get Attendance",
                                            style: TextStyle(
                                                fontSize: height * 0.024,
                                                fontWeight: FontWeight.w600))),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          SizedBox(
            width: width * 0.96,
            child: CupertinoSegmentedControl<int>(
              selectedColor: Color(0xff0056D2),
              children: {
                0: buildSegment('Upcoming'),
                1: buildSegment('Completed'),
              },
              onValueChanged: (int val) {
                setState(() {
                  sharedValue = val;
                });
              },
              groupValue: sharedValue,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: lists[sharedValue],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildSegment(String text) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );

Future<LectureAPI> GetLectureDetails(String? accessToken) async {
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
  return x;
}

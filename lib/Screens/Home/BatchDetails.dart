import 'dart:convert';
import 'package:attendance_portal/Screens/Home/Attendance.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/BatchDataAPI.dart';

class BatchDetails extends StatefulWidget {
  String? refreshToken;
  String? accessToken;
  int? batchID;
  String? endTime;
  String? startTime;
  String? batchName;
  String? subjectName;
  BatchDetails(
      {Key? key,
      this.refreshToken,
      this.accessToken,
      this.batchID,
      this.endTime,
      this.startTime,
      this.batchName,
      this.subjectName})
      : super(key: key);

  @override
  State<BatchDetails> createState() => _BatchDetailsState();
}

class _BatchDetailsState extends State<BatchDetails> {
  bool flag = false;
  var tokens = [];
  var logout = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return SafeArea(
      child: Scaffold(
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
          body: FutureBuilder<List<BatchDataAPI>?>(
            future: GetBatchDetails(widget.accessToken, widget.batchID),
            builder: (context, snapshot) => snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Repetition:",
                              style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            Text(
                              "Once a week",
                              style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 7, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Timing:",
                              style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            Text(
                              "${widget.startTime!} - ${widget.endTime!}",
                              style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 26),
                        child: Text(
                          "Batch Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Table(
                          border: TableBorder
                              .all(), // Allows to add a border decoration around your table
                          children: [
                            TableRow(children: [
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'SAP ID',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                      fontSize: 15),
                                ),
                              )),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Full name',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                      fontSize: 15),
                                ),
                              )),
                            ]),
                          ],
                        ),
                      ),
                      Container(
                          height: height * 0.52,
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 12),
                          child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    border: TableBorder
                                        .all(), // Allows to add a border decoration around your table
                                    children: [
                                      TableRow(children: [
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              snapshot.data![index].sapId
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data![index].name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ]);
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: IntrinsicWidth(
                                      child: Column(
                                        children: [
                                          Text(
                                            "What do you want to edit?",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Montserrat'),
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            thickness: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                        child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "One lecture",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: 2,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Schedule",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  )),
                              child: Center(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: IntrinsicWidth(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Are you sure you want to delete?",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Montserrat'),
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            thickness: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                        child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: 2,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  )),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff0056D2),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Attendance(
                                        details: snapshot.data,
                                      )),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: const Center(
                            child: Text(
                              "Take Attendance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : !snapshot.hasError
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: Text("Error occured!"),
                      ),
          )),
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
  print("Hi");
  List<dynamic> data = jsonDecode(res.body);
  print(data);
  for (int i = 0; i < data.length; i++) {
    x.add(BatchDataAPI.fromJson(data[i]));
  }
  print(x);
  return x;
}

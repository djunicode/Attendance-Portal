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

  Future<String?> downloadAttendance(
      List<att.AttendanceAPI>? attendanceList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? csv;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMMEEEEd().format(now);
    dataOfAttendance.forEach( (item) {
      print("Student: ${item.student} and attendance: ${item.present}");
    });


    // try {
    //   var res = await http.post(
    //     Uri.parse(
    //         'http://attendanceportal.pythonanywhere.com/attendance/download-attendance/'),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'Authorization': 'Bearer $accessToken'
    //     },
    //     body: jsonEncode(
    //         {"present": true, "lecture": 26, "student": 1}
    //     ),
    //   );
    //   //print(dataOfAttendance.map((e) => e.student));
    //   print(res.statusCode);
    //   //print(res.body);
    //
    //   if (res.statusCode == 200 && await Permission.storage.request().isGranted) {
    //     //Utils.showSnackBar1("Download started");
    //     print("Download started");
    //
    //     final directory = await getApplicationSupportDirectory();
    //     print(directory.path);
    //     var path = directory.path;
    //     final file = File('$path/data.csv');
    //
    //
    //
    //     try {
    //       await file.writeAsString(res.body);
    //       OpenFile.open(path, type: csv);
    //     } catch (e) {
    //       print(e.toString());
    //       Utils.showSnackBar(e.toString());
    //     }
    //   } else {
    //     Utils.showSnackBar(res.reasonPhrase);
    //   }
    //   Map data = jsonDecode(res.body);
    //   print(data);
    //   csv = data.toString();
    // } catch (e) {
    //   print(e.toString());
    // }
    List<List<String>> data = [];
    dataOfAttendance.forEach( (item) {
        data.add([item.student.toString(),item.present.toString()]);

      //print("Student: ${item.student} and attendance: ${item.present}");
    });
      // ["1", "1", "1"],
      // ["2", "2", "2"],
      // ["3", "3", "3"],

    String csvData = ListToCsvConverter().convert(data);
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory/csv-$formattedDate.csv";
    print(path);
    final File file = File(path);
    await file.writeAsString(csvData);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return AllCsvFilesScreen(
              //path: path
          );
        },
      ),
    );
    return csv;
  }

  loadCsvFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );
    String? path = result?.files.first.path;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return AllCsvFilesScreen(
              //path: path!
          );
        },
      ),
    );
  }

  Future<List<FileSystemEntity>> _getAllCsvFiles() async {
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory/";
    final myDir = Directory(path);
    List<FileSystemEntity> _csvFiles;
    _csvFiles = myDir.listSync(recursive: true, followLinks: false);
    _csvFiles.sort((a, b) {
      return b.path.compareTo(a.path);
    });
    return _csvFiles;
  }

  Future<List<List<dynamic>>> loadingCsvData(String path) async {
    final csvFile = new File(path).openRead();
    return await csvFile
        .transform(utf8.decoder)
        .transform(
      CsvToListConverter(),
    )
        .toList();
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

//
// <<<<<<< HEAD
//   try {
//     var res = await http.post(
//       Uri.parse(
//           'http://attendanceportal.pythonanywhere.com/attendance/download-attendance/'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $accessToken'
//       },
//       body: jsonEncode(attendanceList),
//     );
//     print(dataOfAttendance.map((e) => e.student));
//     print(res.statusCode);
//     print(res.body);
//
//     if (res.statusCode == 200 && await Permission.storage
//         .request()
//         .isGranted) {
//       Utils.showSnackBar1("Download started");
//
//
//       final directory = await getExternalStorageDirectory();
//       print(directory!.path);
//
//       var path = directory.path;
//       // log(path);
//
//       final file = File('$path/data.csv');
//
//
//       try {
//         await file.writeAsString(res.body);
//         OpenFile.open(path, type: csv);
//       } catch (e) {
//         print(e.toString());
//         Utils.showSnackBar(e.toString());
//       }
//     } else {
//       Utils.showSnackBar(res.reasonPhrase);
//     }
//     Map data = jsonDecode(res.body);
//     print(data);
//     csv = data.toString();
//   } catch (e) {
//     print(e.toString());
//   }
// }
// =======
//
//
// >>>>>>> a4926bc21aac99ad0d2f59575618925974b91ddc

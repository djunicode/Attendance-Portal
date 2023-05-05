import 'package:attendance_portal/Models/Utils.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateLectures extends StatefulWidget {
  const CreateLectures({Key? key}) : super(key: key);

  @override
  State<CreateLectures> createState() => _CreateLecturesState();
}

class _CreateLecturesState extends State<CreateLectures> {
  TextEditingController roomController = new TextEditingController();
  TimeOfDay _timeOfDayfrom = TimeOfDay(hour: 12, minute: 30);
  TimeOfDay _timeOfDayto = TimeOfDay(hour: 12, minute: 30);
  String? _subject;
  String? _startTime;
  String? _endTime;
  String? _batch;
  String? roomNumber;

  void _showTimePickerfrom() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        TimeOfDay? selectedTime = value;
        var replacingTime = selectedTime!
            .replacing(hour: selectedTime!.hour, minute: selectedTime!.minute);

        String formattedTime = replacingTime.hour.toString() +
            ":" +
            replacingTime.minute.toString();
        _timeOfDayfrom = value!;
        _startTime = formattedTime;
      });
    });
  }

  void _showTimePickerto() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        TimeOfDay? selectedTime = value;
        var replacingTime = selectedTime!
            .replacing(hour: selectedTime!.hour, minute: selectedTime!.minute);

        String formattedTime = replacingTime.hour.toString() +
            ":" +
            replacingTime.minute.toString();
        _timeOfDayto = value!;
        _endTime = formattedTime;
      });
    });
  }

  List<DayInWeek> _days = [
    DayInWeek("S"),
    DayInWeek(
      "M",
    ),
    DayInWeek("T", isSelected: true),
    DayInWeek(
      "W",
    ),
    DayInWeek(
      "Th",
    ),
    DayInWeek(
      "F",
    ),
    DayInWeek(
      "Sa",
    ),
  ];

  final list1 = [
    "     Maths",
    "     FLAT",
    "     AOA",
    "     UHV",
    "     OS",
  ];

  final list2 = [
    "     SE Computer Engineering - A",
    "     SE Computer Engineering - B",
    "     SE Computer Engineering - C",
    "     SE Computer Engineering - A3",
  ];

  String? value1;
  String? value2;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    DateTime now = DateTime.now().add(Duration(days: 1));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(DateTime.now());
    
    return Expanded(
      child: SizedBox(
        height: height * 0.85,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 25.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Tomorrow: ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(
                    width: width * 0.14,
                  ),
                  Icon(Icons.calendar_month_sharp)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SelectWeekDays(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                days: _days,
                border: false,
                daysFillColor: Color(0xff0056D2),
                unSelectedDayTextColor: Colors.grey,
                selectedDayTextColor: Colors.white,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [const Color(0xffffff), const Color(0xffffff)],
                    tileMode:
                        TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                onSelect: (values) {
                  // <== Callback to handle the selected days
                  print(values);
                },
              ),
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter room number",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      errorStyle: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide(color: Color(0xff848792)),
                      )),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room number not entered';
                    } else if (value.length > 11) {
                      return "Enter valid room number";
                    }
                    return null;
                  },
                  controller: roomController,
                  onSaved: (value) {
                    roomNumber = roomController.text;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: height * 0.06,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: const Text("Select Batch"),
                    ),
                    value: value2,
                    isExpanded: true,
                    items: list2.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        value2 = value;
                        _batch = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _showTimePickerfrom,
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            )),
                        child: Center(
                            child: Text(
                          _timeOfDayfrom.format(context).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: _showTimePickerto,
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            )),
                        child: Center(
                            child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text("To "),
                            ),
                            Text(
                              _timeOfDayto.format(context).toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: height * 0.06,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: const Text("Select Subject "),
                    ),
                    value: value1,
                    isExpanded: true,
                    items: list1.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        value1 = value;
                        _subject = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff0056D2),
                ),
                child: InkWell(
                  onTap: () async {

                    await createLecture(
                      roomNumber,
                      _startTime,
                      _endTime,
                      formattedDate,
                      'note',
                      true,
                      1,
                      9,
                      2,
                    );
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Center(
                    child: Text(
                      "Create Lecture",
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
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ));
}

Future<String?> createLecture(
  String? roomNumber,
  String? startTime,
  String? endTime,
  String? date,
  String? note,
  bool? attendanceTaken,
  int? teacher,
  int? batch,
  int? subject,
) async {
  String? lecId;
  var res = await http.post(
    Uri.parse('http://attendanceportal.pythonanywhere.com/attendance/lecture/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "roomNumber": "$roomNumber",
      "endTime": "$endTime",
      "startTime": "$startTime",
      "date": "$date",
      "note": "$note",
      "attendanceTaken": "$attendanceTaken",
      "teacher": "$teacher",
      "batch": "$batch",
      "subject": "$subject",
    }),
  );
  print(res.statusCode);
  print(res.body);
  if (res.statusCode == 201) {
    Utils.showSnackBar1("Lecture created");
  } else {
    Utils.showSnackBar("Enter correct value");
  }
  Map data = jsonDecode(res.body);

  lecId = data["lecture"]["date"].toString();
  print(lecId);

  return lecId;
}

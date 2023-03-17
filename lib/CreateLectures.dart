import 'package:day_picker/day_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateLectures extends StatefulWidget {
  const CreateLectures({Key? key}) : super(key: key);

  @override
  State<CreateLectures> createState() => _CreateLecturesState();
}

class _CreateLecturesState extends State<CreateLectures> {
  TimeOfDay _timeOfDayfrom = TimeOfDay(hour: 12, minute: 30);
  TimeOfDay _timeOfDayto = TimeOfDay(hour: 12, minute: 30);

  void _showTimePickerfrom(){
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDayfrom = value!;
      });
    } );
  }
  void _showTimePickerto(){
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDayto = value!;
      });
    } );
  }
  List<DayInWeek> _days = [
    DayInWeek(
        "S"
    ),
    DayInWeek(
      "M",
    ),
    DayInWeek(
        "T",
        isSelected: true
    ),
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
    "     Two Times",
    "     Three Times",
    "     Four Times",
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
    DateTime now = DateTime.now().add(Duration(days: 1));
    String formattedDate = DateFormat.MMMEd().format(now);
    return SizedBox(
      height: 456,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32,32,32,25.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Tomorrow - ",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                Text(formattedDate,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                SizedBox(width: 135,),
                Icon(Icons.calendar_month_sharp)
              ],
            ),
            SizedBox(height: 15,),
            SelectWeekDays(
              fontSize:14,
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
              onSelect: (values) { // <== Callback to handle the selected days
                print(values);
              },
            ),
            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Text("Select Batch:"),
                  ),
                  value: value2,
                  isExpanded: true,
                  items: list2.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      this.value2 = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 19,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap:_showTimePickerfrom,
                    child: Container(
                      height: 60,
                      width: 154,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                      ),
                      child: Center(
                          child: Text(_timeOfDayfrom.format(context).toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)),

                    ),
                  ),
                  SizedBox(width: 35,),
                  GestureDetector(
                    onTap: _showTimePickerto,
                    child: Container(
                      height: 60,
                      width: 154,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                      ),
                      child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("To "),
                              ),
                              Text(_timeOfDayto.format(context).toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                            ],
                          )),

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Text("Frequency: "),
                  ),
                  value: value1,
                  isExpanded: true,
                  items: list1.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      this.value1 = value;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 20,),

            Container(
              height: 50,
              width: double.infinity,
              // margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff0056D2),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
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

    );

  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ));
}

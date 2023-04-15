import 'package:attendance_portal/Screens/BatchDetails.dart';
import 'package:attendance_portal/Screens/Home/CreateLectures.dart';
import 'package:attendance_portal/Screens/Home/postCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key? key})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int groupValue = 0;

  final Map<int, Widget> lists = <int, Widget>{
    0: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(31.0, 19, 200, 0.0),
                child: index <= 4
                    ? Text(
                        "Mar 4 Tomorrow ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Next Week",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
              ),
              PostCard(),
            ],
          );
        }),
    1: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 19, 239, 0.0),
                child: Text("Yesterday",
                    style:
                        TextStyle(fontWeight: FontWeight.w200, fontSize: 16)),
              ),
              PostCard(),
            ],
          );
        }),
  };

  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().add(Duration(days: 1));
    String formattedDate = DateFormat.MMMEd().format(now);
    print(formattedDate);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height*0.12,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Lectures",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: height*0.045),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => MentalHealth()));
              },
              icon: Icon(
                Icons.filter_alt,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: height*0.19,
                        width: width*0.3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.fromLTRB(
                                    width*0.21, 0, 0, 0.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.add_circle_outline),
                                    SizedBox(width: 4,),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (_) => CreateLectures(),
                                          );
                                        },
                                        child: Text(
                                          "Create a lecture",
                                          style: TextStyle(
                                              fontSize: height*0.024,
                                              fontWeight: FontWeight.w600),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    width*0.21, 0, 0, 0.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.people),
                                    SizedBox(width: 4,),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => BatchDetails()),
                                          );
                                        },
                                        child: Text("Create a new batch",
                                            style: TextStyle(
                                                fontSize: height*0.024,
                                                fontWeight:
                                                FontWeight.w600))
                                    ),
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
            width: width*0.96,
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


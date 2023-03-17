import 'dart:convert';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:attendance_portal/CreateLectures.dart';
import 'package:attendance_portal/Utils.dart';
import 'package:attendance_portal/log.dart';
import 'package:attendance_portal/postCard.dart';
import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {

  String? refreshToken;
  String? accessToken;
  Home({Key? key, required this.refreshToken, required this.accessToken})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int groupValue = 0;
  var tokens = [];
  var logout = [];
  bool flag = false;
  final Map<int, Widget> lists =  <int, Widget>{
    0: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(31.0,19,200,0.0),
                child: index<=4?Text("Mar 4 Tomorrow",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Next Week",style: TextStyle(color: Colors.blue),),
                ),
              ),
              PostCard(),
            ],
          );
        }),
    1: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,19,239,0.0),
                child: Text("Yesterday",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 16)),
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
    print(widget.accessToken);
    print(widget.refreshToken);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Lectures",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 31.42),
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
                      builder: (BuildContext context){
                        return SizedBox(
                          height: 152,
                          width: 390,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(107.0,0,34,0.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_circle_outline),
                                      TextButton(
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (_) => CreateLectures(),
                                                );
                                          },
                                          child: Text("Create a lecture",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                                    ],
                                  ),
                                ),
                                Divider(color: Colors.grey.shade300,thickness: 2,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(107.0,0,34,0.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.people),
                                      TextButton(
                                          onPressed: (){},
                                          child: Text("Create a new batch",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))),
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

        // Center(
        //   child: Column(
        //     children: [
        //       Padding(padding: EdgeInsets.all(10.0)),
        //       ElevatedButton(
        //         child: Text("Refresh"),
        //         onPressed: () async {
        //           tokens = await refreshLogin(widget.refreshToken);
        //           if (tokens[0] == null) {
        //             Utils.showSnackBar(tokens[1]);
        //           } else {
        //             setState(() {
        //               flag = true;
        //             });
        //           }
        //         },
        //       ),
        //       Padding(padding: EdgeInsets.all(10.0)),
        //       flag
        //           ? Padding(
        //               padding: EdgeInsets.all(10),
        //               child: Center(
        //                 child: Text("New access token is " + tokens[0]),
        //               ),
        //             )
        //           : Padding(
        //               padding: EdgeInsets.all(10),
        //               child: Center(child: Text("Click to refresh"))),
        //       Padding(padding: EdgeInsets.all(10.0)),
        //       ElevatedButton(
        //         child: Text("Logout"),
        //         onPressed: () async {
        //           tokens = await Logout(widget.refreshToken);
        //           if (tokens[0] == "200") {
        //             Utils.showSnackBar1(tokens[1]);
        //             Navigator.of(context).pop();
        //             Navigator.of(context)
        //                 .push(MaterialPageRoute(builder: (context) => Log()));
        //           } else {
        //             Utils.showSnackBar(tokens[2]);
        //           }
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body:
            Column(
          children: <Widget>
          [
            const Padding(
              padding: EdgeInsets.all(10.0),
            ),
            SizedBox(
              width: 500.0,
              child: CupertinoSegmentedControl<int>(
                selectedColor:Color(0xff0056D2),
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

Future<List<String?>> refreshLogin(String? refreshToken) async {
  String? token2, token3;
  var res = await http.post(
    Uri.parse(
        'http://attendanceportal.pythonanywhere.com/accounts/login/refresh/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"refresh": "$refreshToken"}),
  );
  print(res.body);
  Map data = jsonDecode(res.body);
  token2 = data['access'];
  token3 = data['detail'];
  var list = [token2, token3];
  print(list);
  return list;
}

Future<List<String?>> Logout(String? refreshToken) async {
  String? token1, token2, token3;
  var res = await http.post(
    Uri.parse('http://attendanceportal.pythonanywhere.com/accounts/logout/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"refresh": "$refreshToken"}),
  );
  print(res.body);
  Map data = jsonDecode(res.body);
  token1 = data['error'];
  token2 = data['status'].toString();
  token3 = data['message'];
  var list = [token2, token3, token1];
  print(list);
  return list;
}

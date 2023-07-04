import 'dart:convert';
import 'package:attendance_portal/Models/teacher_profile.dart';
import 'package:attendance_portal/Screens/Home/LectureDetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Utils.dart';
import '../../Auth/log.dart';

class ProfilePage extends StatefulWidget {
  String? refreshToken;
  String? accessToken;
  ProfilePage({Key? key, required this.refreshToken, required this.accessToken})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool flag = false;
  var tokens = [];
  var logout = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return FutureBuilder(
      future: GetTeacherDetails(widget.accessToken),
      builder: (context, snapshot) => snapshot.hasData
          ? Scaffold(
              appBar: AppBar(
                toolbarHeight: height * 0.12,
                elevation: 0.7,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Column(
                  children: [
                    Text(
                      snapshot.data![1],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          fontFamily: 'Montserrat'),
                    ),
                    Text(
                      snapshot.data![0],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(31, 24, 31, 24),
                      shape: Border(
                        bottom: BorderSide(),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LectureDetails()));
                      },
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0056D2),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        ),
                        child: Text("Logout"),
                        onPressed: () async {
                          tokens = await Logout(widget.refreshToken);
                          if (tokens[0] == "200") {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool('flag', false);
                            await prefs.setString('accessToken', '');
                            await prefs.setString('refreshToken', '');
                            Utils.showSnackBar1(tokens[1]);
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Log()));
                          } else {
                            Utils.showSnackBar(tokens[2]);
                          }
                        },
                      ),
                      title: Text(
                        "Your Batches",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Montserrat',
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ListView.builder(
                    //     physics: ClampingScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: snapshot.data![3],
                    //     itemBuilder: (BuildContext context, int index) {
                    //       int c = snapshot.data![3];
                    //       return ListTile(
                    //         contentPadding: EdgeInsets.fromLTRB(31, 5, 31, 5),
                    //         shape: Border(
                    //           bottom: BorderSide(),
                    //         ),
                    //         onTap: () {
                    //           Navigator.of(context).push(MaterialPageRoute(
                    //               builder: (context) => LectureDetails()));
                    //         },
                    //         trailing: IconButton(
                    //           onPressed: () {},
                    //           icon: Icon(Icons.arrow_forward_ios),
                    //         ),
                    //         title: Text(
                    //           "Sem ${snapshot.data![3]} ${snapshot.data![index + 4]}",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w600,
                    //               fontFamily: 'Montserrat',
                    //               fontSize: 16),
                    //         ),
                    //         subtitle: Text(
                    //           snapshot.data![index + 2 * c + 4],
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w400, fontSize: 13),
                    //         ),
                    //       );
                    //     }),
                  ],
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

Future<List<String?>> Logout(String? refreshToken) async {
  String? token1, token2, token3;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  refreshToken = prefs.getString('refreshToken');
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

Future<List> GetTeacherDetails(String? accessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  accessToken = prefs.getString('accessToken');
  print(accessToken);
  var res = await http.get(
    Uri.parse(
        'http://attendanceportal.pythonanywhere.com/accounts/teacher-profile/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    },
  );
  print(res.body);
  print(res.statusCode);
  Map<String, dynamic> data = jsonDecode(res.body);
  var x = TeacherProfile.fromJson(data);
  print(x.specialization);
  print(x.subjects[0].name);
  var list = [
    x.specialization,
    "${x.user.firstName} " "${x.user.middleName} ${x.user.lastName}",
    x.id,
    x.subjects.length,
  ];
  for (int i = 0; i < x.subjects.length; i++) {
    list.add(x.subjects[i].department.name);
  }
  for (int i = 0; i < x.subjects.length; i++) {
    list.add(x.subjects[i].semester);
  }
  for (int i = 0; i < x.subjects.length; i++) {
    list.add(x.subjects[i].name);
  }
  print(list);
  return list;
}

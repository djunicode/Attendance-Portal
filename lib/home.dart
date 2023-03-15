import 'dart:convert';
import 'package:attendance_portal/Utils.dart';
import 'package:attendance_portal/log.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  String? refreshToken;
  String? accessToken;
  Home({Key? key, required this.refreshToken, required this.accessToken})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tokens = [];
  var logout = [];
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    print(widget.accessToken);
    print(widget.refreshToken);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10.0)),
              ElevatedButton(
                child: Text("Refresh"),
                onPressed: () async {
                  tokens = await refreshLogin(widget.refreshToken);
                  if (tokens[0] == null) {
                    Utils.showSnackBar(tokens[1]);
                  } else {
                    setState(() {
                      flag = true;
                    });
                  }
                },
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              flag
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text("New access token is " + tokens[0]),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child: Text("Click to refresh"))),
              Padding(padding: EdgeInsets.all(10.0)),
              ElevatedButton(
                child: Text("Logout"),
                onPressed: () async {
                  tokens = await Logout(widget.refreshToken);
                  if (tokens[0] == "200") {
                    Utils.showSnackBar1(tokens[1]);
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Log()));
                  } else {
                    Utils.showSnackBar(tokens[2]);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

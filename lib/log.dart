import 'package:attendance_portal/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home.dart';

class Log extends StatefulWidget {
  const Log({Key? key}) : super(key: key);

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  final TextEditingController _sapController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String sap = "", password = "";
  bool hidden = true;
  var tokens = [];

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _sapController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/lovepik-college-girl-library-study-picture_500587696.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                            spreadRadius: 2)
                      ],
                      color: Colors.white),
                  width: 330,
                  height: 550,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset('assets/images/dj sanghvi logo.png',
                            height: 96, width: 105),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Welcome back.",
                              style: (GoogleFonts.getFont(
                                'Montserrat',
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              )),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        Container(
                          padding: EdgeInsets.only(left: 27, right: 35.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5)),
                                    Text(
                                      "SAP ID",
                                      style: (GoogleFonts.getFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      )),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(13),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Enter SAP ID",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide:
                                          BorderSide(color: Color(0xff848792)),
                                    )),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Sap Id';
                                  } else if (value.length < 11) {
                                    return "Sap Id has 11 digits";
                                  }
                                  return null;
                                },
                                controller: _sapController,
                                onSaved: (value) {
                                  sap = value!;
                                },
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5)),
                                    Text(
                                      "Password",
                                      style: (GoogleFonts.getFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      )),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  TextFormField(
                                    obscureText: hidden,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Enter your password",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500),
                                      suffix: InkWell(
                                        onTap: () {
                                          setState(() {
                                            hidden = !hidden;
                                          });
                                        },
                                        child: Icon(
                                          !hidden
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 20,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff848792))),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password not entered';
                                      } else if (value.length < 7) {
                                        return "Enter minimum six characters";
                                      }
                                      return null;
                                    },
                                    controller: _passwordController,
                                    onSaved: (value) {
                                      password = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Forgot password?",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff0056D2),
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.0,
                                height: 20.0,
                              ),
                              Center(
                                child: SizedBox(
                                    height: 55,
                                    width: 300,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        if (formKey.currentState!.validate()) {
                                          sap = _sapController.text.trim();
                                          password = _passwordController.text.trim();
                                          tokens = await LoginGetTokens(sap, password);
                                          print(tokens);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF0056D2),
                                        foregroundColor: Colors.black,
                                      ),
                                      child: Text(
                                        "Sign In",
                                        style: (GoogleFonts.getFont('Inter',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 20.0,
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      )),
    );
  }
}

Future<List<AutoGenerate>> getData() async {
  List<AutoGenerate> list = [];
  String url = "http://192.168.29.59:8021/food_userview/";
  http.Response response = await http.get(Uri.parse(url));
  print(response.body);
  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var rest = data as List;
      print(rest);
      list = rest.map<AutoGenerate>((json) => AutoGenerate.fromJson(json)).toList();
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e.toString());
  }
  return list;
}

Future<List<String>> LoginGetTokens(String? SAPID, String? Password) async{
  var res = await http.post(
    Uri.parse('http://attendanceportal.pythonanywhere.com/accounts/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "sap_id": "$SAPID",
      "password": "$Password"
    }),
  );
  print(res.body);
  Map data = jsonDecode(res.body);
  String token1 = data['refresh'];
  String token2 = data['access'];
  var list = [token1, token2];
  return list;
}
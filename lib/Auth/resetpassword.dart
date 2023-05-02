import 'dart:convert';
import 'package:attendance_portal/Models/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  List<String?> list = [];
  String? email;
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/lovepik-college-girl-library-study-picture_500587696.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(right: 300.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF0056D2),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_sharp),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                    height: 500,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 10.0,
                            height: 30.0,
                          ),
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
                                "Reset password",
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5)),
                                      Text(
                                        "Email",
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
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(13),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Enter Email",
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff848792)),
                                      )),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) {
                                    if (email != null &&
                                        !EmailValidator.validate(email)) {
                                      return 'Please enter a Valid Email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    email = _emailController.text.trim();
                                  },
                                ),
                                Padding(padding: EdgeInsets.all(10.0)),
                                SizedBox(
                                  width: 10.0,
                                  height: 20.0,
                                ),
                                Center(
                                  child: SizedBox(
                                      height: 55,
                                      width: 300,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            email =
                                                _emailController.text.trim();
                                            list = await resetPassword(email);
                                            if (list[0] == '200') {
                                              Utils.showSnackBar1(list[2]);
                                            } else {
                                              Utils.showSnackBar(list[1]);
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF0056D2),
                                          foregroundColor: Colors.black,
                                        ),
                                        child: Text(
                                          "Get Reset Link",
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
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      )),
    );
  }
}

Future<List<String?>> resetPassword(String? email) async {
  String? token1, token2, token3;
  var res = await http.post(
    Uri.parse(
        'http://attendanceportal.pythonanywhere.com/accounts/password-reset/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"email": "$email"}),
  );
  print(res.body);
  Map data = jsonDecode(res.body);
  token1 = data['status'].toString();
  token2 = data['error'];
  token3 = data['message'];
  var list = [token1, token2, token3];
  return list;
}

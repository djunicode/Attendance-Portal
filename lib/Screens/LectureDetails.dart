import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Utils.dart';
import '../../Auth/log.dart';

class LectureDetails extends StatefulWidget {
  LectureDetails({Key? key}) : super(key: key);

  @override
  State<LectureDetails> createState() => _LectureDetails();
}

class _LectureDetails extends State<LectureDetails> {
  bool flag = false;

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
                "SE Comps",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 19.42,
                    fontFamily: 'Montserrat'),
              ),
              Text(
                "Maths",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                  shape: Border(
                    bottom: BorderSide(),
                  ),
                  onTap: () {},
                  contentPadding: EdgeInsets.fromLTRB(31, 24, 31, 24),
                  trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0056D2),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.white,
                        size: 35,
                      )),
                  title: Text(
                    "Batch Details",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        fontSize: 25),
                  )),
              ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(31, 5, 31, 5),
                      shape: Border(
                        bottom: BorderSide(),
                      ),
                      onTap: () {},
                      trailing: FloatingActionButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          'assets/images/Clear.svg',
                        ),
                        backgroundColor: Color(0xff0056D2),
                        heroTag: UniqueKey(),
                      ),
                      title: Text(
                        "60004210046",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                            fontSize: 16),
                      ),
                      subtitle: Text(
                        "Full name",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

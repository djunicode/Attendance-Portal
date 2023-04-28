import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Utils.dart';
import '../../Auth/log.dart';

class LectureDetails extends StatefulWidget {
  String? refreshToken;
  String? accessToken;
  LectureDetails({Key? key, required this.refreshToken, required this.accessToken})
      : super(key: key);

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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height*0.12,
        elevation: 0.7,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            Text("SE Computer Engineering",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 28,fontFamily: 'Montserrat'),
            ),
            Text("Maths",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Batch Details",
                  style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Montserrat',fontSize:18 ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0056D2),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                  ),
                    onPressed: () {},
                    child: Icon(Icons.add_outlined,
                      color: Colors.white,
                      size: 35,
                    )
                ),

              ],
            ),
            SizedBox(height: 10,),
            Divider(thickness: 1,color: Colors.black,),
            ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    shape: Border(
                      bottom: BorderSide(),
                    ),
                    onTap: () {},
                    trailing: FloatingActionButton(
                      onPressed: () {},
                      child: SvgPicture.asset('assets/images/Clear.svg',),
                      backgroundColor: Color(0xff0056D2)
                    ),
                    title: Text("60004210046",
                      style: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Montserrat',fontSize: 12),
                    ),
                    subtitle: Text("Full name",
                      style: TextStyle(fontWeight: FontWeight.bold,),

                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}



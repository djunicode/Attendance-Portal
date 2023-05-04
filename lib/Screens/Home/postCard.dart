import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'BatchDetails.dart';

class PostCard extends StatefulWidget {
  String? refreshToken;
  String? accessToken;
  String? batch;
  String? startTime;
  String? endTime;
  String? subject;
  int? batchID;
  String? batchName;
  String? subjectName;
  int? lectureID;

  PostCard(
      {Key? key,
      required this.refreshToken,
      required this.accessToken,
      required this.batch,
      required this.endTime,
      required this.startTime,
      required this.subject,
      required this.batchID,
      required this.subjectName,
      required this.batchName,
      required this.lectureID})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return SizedBox(
      height: height * 0.2,
      width: width * 0.88,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BatchDetails(
              batchID: widget.batchID,
              startTime: widget.startTime,
              endTime: widget.endTime,
              batchName: widget.batchName,
              subjectName: widget.subjectName,
              lectureID: widget.lectureID,
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFdedede), width: 1)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Batch: " + widget.batch!,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.startTime! + " - " + widget.endTime!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(
                      width: width * 0.40,
                    ),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: SvgPicture.asset('assets/images/Clear.svg'),
                        backgroundColor: Color(0xff0056D2),
                        heroTag: UniqueKey(),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.subject!,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

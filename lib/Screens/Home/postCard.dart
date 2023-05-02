import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFdedede), width: 1)),
        height: height*0.3,
        width: width*0.88,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 22, 60, 0.0),
              child: Text(
                "SE Computer Engineering-A3",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    fontFamily: 'Montserrat'),
              ),
            ),
            // SizedBox(height: 14,),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.fromLTRB(
                    40.0,
                    0.0,
                    width*0.2,
                    0,
                  ),
                  child: Text(
                    "12:30 PM-1:30 PM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: SvgPicture.asset('assets/images/Clear.svg'),
                  backgroundColor: Color(0xff0056D2),
                )
              ],
            ),
            // SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                10.0,
                0.0,
                148,
                0,
              ),
              child: Text(
                "Computer Networks",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

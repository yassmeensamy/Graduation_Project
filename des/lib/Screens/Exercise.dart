import 'package:des/Screens/Home.dart';
import 'package:des/Screens/TopicsMeditation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart' as constants;

class ExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        title: Text(
          "Exercise",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,

        backgroundColor: Colors.transparent,
      ),
      body: Scaffold(
  backgroundColor: constants.pageColor,
  appBar: AppBar(
    title: Text(
      "Exercise",
      style: TextStyle(color: Colors.black),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
  ),
  body: SingleChildScrollView(
    child: Column(
      children: [
        RectangleContainer(
          constants.mint,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Meditation",
                    style: TextStyle(
                      fontFamily: GoogleFonts.nunitoSans().fontFamily,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Meditation lolllllllllllllllllllllllllllllllllllllllllllllllllllllll ",
                    textAlign: TextAlign.left,
                    softWrap: true,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopicMediation(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Start Now',
                              style: TextStyle(
                                color: constants.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Icon(
                              Icons.play_arrow,
                              color: constants.green,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Image.asset("assets/images/Image Container2.png"),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
      )
    );
  }
}
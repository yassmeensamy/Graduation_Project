import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//Error Kebeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer
/*
class ReportScreen extends StatelessWidget {
  List<String> moods = ["Disappointed", "offfffff"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: EdgeInsets.only(top: 100, right: 20, left: 20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            width: 376,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 140, 65, 65),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 3),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/Emotions/Sad.png",
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(width: 13),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sad",
                            style: TextStyle(
                              fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "20:11",
                            style: TextStyle(
                              fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Spacer(), // Added Spacer to push "Edit" to the right
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                          color: Color(0xff8B4CFC),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("You felt"),

                    ),
                    /*
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: moods.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            index == moods.length - 1
                                ? moods[index]
                                : '${moods[index]}, ',
                            style: TextStyle(
                              fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                            ),
                          );
                          
                        },
                      ),
                      */
                      
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
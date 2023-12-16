import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Result extends StatelessWidget {
   final int total_score;
  Result({required this.total_score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:Center(child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Padding(padding: EdgeInsets.only(top:42),
          child:
          Row(
            children: [
              IconButton(
                onPressed: () 
                {
                  // Add your onPressed logic here
                },
                icon: Icon(Icons.arrow_back),
                
              ),
              SizedBox(width: 100,),
              Text("Result",style: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily,fontSize: 32,fontWeight: FontWeight.bold)),
              // Add other widgets for the Row here
            ],
          ),
          ),
          SizedBox(height: 80),
          Center(
          child :
          Container(
            decoration: BoxDecoration(
                border: Border.all(width:17,color: Colors.transparent ),
                shape: BoxShape.circle,
                 gradient: LinearGradient(
                  begin: Alignment.topLeft,      // Starting point
                 end: Alignment.bottomRight,
                colors:  [Color(0xFF6495ED), Color(0xFFB57EDC)], 
                // Your gradient colors
              ), // Set your desired background color
              ),
              child:
               Container(
              width: 230.0, // Adjust the width as needed
              height: 230.0, // Adjust the height as needed
              decoration: BoxDecoration(
                border: Border.all(width:0,color: Colors.transparent ),
                shape: BoxShape.circle,
                color: Colors.white, // Set your desired background color
              ),
              child: Center(
                child: Text(
                  "$total_score/125",
                  style: TextStyle(
                    fontFamily: GoogleFonts.comfortaa().fontFamily,
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6495ED),
                  ),
                ),
              ),
            ), 
          ),
          ),
          
          SizedBox(height: 30,),
           Text("Normal",style: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily,fontSize: 50,fontWeight: FontWeight.bold)),
          SizedBox(height: 30,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 28),
            child:
            Center(child:
            Text("Lorem ipsum dolor sit amet consectetur, adipisicing elit. Mollitia aut ipsa.",
      style: TextStyle(fontSize: 24.0,fontFamily: GoogleFonts.comfortaa().fontFamily,fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,),
          ),
      ), 
        ],
      ),
      ),
    );
  }
}

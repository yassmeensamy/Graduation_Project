import 'package:des/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
   final int total_score;
  const ResultScreen({super.key, required this.total_score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:Center(child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Padding(padding: const EdgeInsets.only(top:42),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              Center(child:
              Text("Result",style: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily,fontSize: 32,fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 50),
              IconButton(
                onPressed: () 
                {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>const Home()));
                },
                
                icon: const Icon(Icons.close),
              ), 
            ],
          ),
          ),
          const SizedBox(height: 80),
          Center(
          child :
          Container(
            decoration: BoxDecoration(
                border: Border.all(width:17,color: Colors.transparent ),
                shape: BoxShape.circle,
                 gradient: const LinearGradient(
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
                    color: const Color(0xFF6495ED),
                  ),
                ),
              ),
            ), 
          ),
          ),
          
          const SizedBox(height: 30,),
           Text("Normal",style: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily,fontSize: 50,fontWeight: FontWeight.bold)),
          const SizedBox(height: 30,),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 28),
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

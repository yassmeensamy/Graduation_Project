import 'package:flutter/material.dart';

class CardQuestion extends StatelessWidget {
  final String Question;
  //final int QuestionNumber;
  CardQuestion ( {required this.Question,/*required this.QuestionNumber*/});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30), ),
            // Add shadow by setting elevation
            
            child: Container(
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    offset: Offset(0, 3), // Offset (x, y) controls the shadow's position
                    blurRadius: 2, // Spread of the shadow
                    spreadRadius: 1, // Optional, controls the size of the shadow
                  ),
                  
                ],
                
              ),
              
              child: Center(
                child: Text(
                  Question,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          /*
          Positioned(child: 
           CircularPercentIndicator(
            progressColor: Color(0xFF134F0E), // Use Color(0xFFRRGGBB) format
           backgroundColor: const Color.fromARGB(255, 127, 204, 184),

            radius: 30,
            lineWidth: 5.0,
            percent: 15/ 25,
            center: Text(
              "30",
              style: TextStyle(fontSize: 30),
            ),
          ),
          left: 140,
          top:-10,
          )
          */
        ],
      ),
    );
  }
}

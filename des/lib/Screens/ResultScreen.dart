import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int total_score;
  ResultScreen( {required this.total_score});
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Asset/Image/fianl2.png"), // Correct the image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            child: Text(
              total_score.toString(),
              style: TextStyle(
                fontFamily: "Oswald",
                fontSize: 100,
                color: Color.fromARGB(255, 27, 134, 15),
                
              ),
            ),
            top: 210,
            left: 90,
          ),
          Positioned(
            child: Text(
              "This is a long paragraph that will automatically wrap to the next line when it reaches the edge of the screen or a specified width. You can use",
              softWrap: true,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            top: 500,
            left: 10,
            width: 360,
          ),
           Positioned(
            child:
          Container(
            width: 300, // Set the desired width
            height: 50, // Set the desired height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), // Correct the BorderRadius
            ),
            child: ElevatedButton(
              onPressed: () {
                // Button click logic
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 19, 79, 14)), // Set the desired color
              ),
              child: Text('Next'),
            ),
          ),
           top: 700,
            left: 20,
           )
        ],
      );
    
  }
}

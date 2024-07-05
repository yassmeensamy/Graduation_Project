import 'dart:math';
import '/constants.dart' as constants;
import 'package:flutter/material.dart';

class TemporaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // Close this screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
               constants.babyBlue30.withOpacity(1), // Start color with opacity
               constants.babyBlue30.withOpacity(.05), // End color with opacity
            ],
          ),
        ),
        child: 
          Center(
        child: Text(
          getRandomMotivation(),
          style: TextStyle(fontSize: 30, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        ),
      ),
    );
  }
}

List<String> motivationalSentences = [
  "Success is not just about accomplishing tasks, but about the journey of growth and perseverance.",
  "Every task completed today is a step closer to your dreams tomorrow.",
  "Celebrate today's victories, no matter how small, for they pave the way to greater achievements.",
  "The satisfaction of completing tasks fuels tomorrow's determination.",
  "Each task conquered today builds the foundation for a stronger, more resilient you.",
  "Embrace the peace that comes with a day well-lived and tasks well-done.",
  "Your persistence today sets the stage for your success tomorrow.",
  "Reflect on today's achievements as fuel for tomorrow's ambitions.",
  "The end of today's tasks is just the beginning of tomorrow's opportunities.",
  "Take pride in your progress today; you're closer to your goals than yesterday."
];

String getRandomMotivation() {
  Random random = Random();
  int index = random.nextInt(motivationalSentences.length-1);
  return motivationalSentences[index];
}

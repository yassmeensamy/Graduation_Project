import 'package:flutter/material.dart';

class MoodImprovementScreen extends StatelessWidget {
  final double moodImprovementPercentage;

  const MoodImprovementScreen({super.key, required this.moodImprovementPercentage});

  @override
  Widget build(BuildContext context) {
    print("improvement");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Improvement'),
      ),
      body: Center(
        child: Text(
          'Your mood improvement is ${moodImprovementPercentage.toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
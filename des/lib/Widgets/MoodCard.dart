import 'package:flutter/material.dart';
import '../constants.dart' as constants;
import '../Models/SecondMoodModel.dart';

class MoodCard extends StatefulWidget {
  final bool isSelected;
  final Function(bool) onPressed;
  final SecondMoodModel mood;

  const MoodCard({super.key, 
    required this.isSelected,
    required this.onPressed,
    required this.mood,
  });

  @override
  _MoodCardState createState() => _MoodCardState();
}

class _MoodCardState extends State<MoodCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed(!widget.isSelected);
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: widget.isSelected ? constants.mint : Colors.white10,
          border: Border.all(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 3,),
              Image.asset(
                widget.mood.ImagePath, 
                height: 65,
                width: 65,
              ),
              const SizedBox(height: 4),
              Text(
                widget.mood.moodText, 
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

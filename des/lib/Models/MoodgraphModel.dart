import 'package:flutter/material.dart';

class MoodGraphModel 
{
  final int moodcount;
  final String mood;
  Color? colormood ;

  MoodGraphModel ({required this.moodcount, required this.mood,this.colormood});
  /*
  factory MoodGraphModel .fromJson(Map<String, dynamic> json)
   {
        return MoodGraphModel(: json['total_score'],
                          level_of_depression: json['level_of_depression'],
                          timestamp: json['timestamp']);
  }
 */
}

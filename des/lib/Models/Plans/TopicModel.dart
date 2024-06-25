
import 'package:des/Models/Plans/AcivityModel.dart';
import 'package:flutter/material.dart';

class TopicModel {
  int id;
  String name;
  String colorTheme;
  String image;
  List<ActivityplanModel> Activities;

  TopicModel({
    required this.id,
    required this.name,
    required this.colorTheme,
    required this.image,
     required this.Activities,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json)
   {
    Map<String, dynamic>? maintopic =json["activities"];
    List<ActivityplanModel>activitiesList=[];
    if(maintopic!=null)
    {
         List<dynamic>Topics= json['subtopics'] ??[];
          if(Topics.isNotEmpty)
          {
               activitiesList=Topics.map((e) {return ActivityplanModel.fromJson(e);},).toList();
          }
    }
    return TopicModel
    (
      id: json['id'] ,
      name: json['name'],
      colorTheme: json['color'] ,
      image: json['image'] ,
      Activities: activitiesList,
    ); 
  }
  

}

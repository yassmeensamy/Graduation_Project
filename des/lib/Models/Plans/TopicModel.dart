
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
    Map<String,dynamic> ? maintopic =json['topic'];
    List<ActivityplanModel>activitiesList=[];
    if(maintopic!=null)
    {
         List<dynamic> Activities= json["activities"] ?? [];;
          if(Activities.isNotEmpty)
          {
               activitiesList=Activities.map((e) {return ActivityplanModel.fromJson(e) ;
               }).toList();
          }
            
          
    }
    return TopicModel
    (
      id: json['id'] ?? maintopic!["id"],
      name: json['name'] ?? maintopic!["name"],
      colorTheme: json['color']??maintopic!["color"] ,
      image: json['image'] ?? maintopic!["image"],
      Activities: activitiesList,
    ); 
  }
  

}

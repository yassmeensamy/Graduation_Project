import 'package:des/Models/Plans/AcivityModel.dart';

class TopicModel {
  int id;
  String name;
  String colorTheme;
  String image;
  List<ActivityplanModel> Activities;
  String description;
  bool enrolled;

  TopicModel({
    required this.id,
    required this.name,
    required this.colorTheme,
    required this.image,
    required this.Activities,
    required this.description,
    required this.enrolled,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    //print(json);
    Map<String, dynamic>? maintopic = json['topic'];
    List<ActivityplanModel> activitiesList = [];
    if (maintopic != null) 
    {
      List<dynamic> Activities = json["activities"] ?? [];
      
      if (Activities.isNotEmpty) 
      {
        
        activitiesList = Activities.map((e) {return ActivityplanModel.fromJson(e);}).toList();
      } 
      else {
        dynamic acivity = json["activity"];
        activitiesList.add(ActivityplanModel.fromJson(acivity));
      }
    }
    return TopicModel(
      id: json['id'] ?? maintopic!["id"],
      name: json['name'] ?? maintopic!["name"],
      colorTheme: json['color'] ?? maintopic!["color"],
      image: json['image'] ?? maintopic!["image"],
      description: json["description"] ?? maintopic!["description"],
      enrolled: json["enrolled"] ?? maintopic!["enrolled"],
      Activities: activitiesList,
    );
  }
}

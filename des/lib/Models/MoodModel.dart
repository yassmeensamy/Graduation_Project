import 'dart:ui';

import '../constants.dart' as constants;
class MoodModel 
{
final String Text;
final String? Description;
final String? ImagePath;
final num?count;
Color? colormood ;
 MoodModel ({required this.Description,required this.ImagePath ,required this.Text ,this.count ,this.colormood});
 
 factory MoodModel.fromJson(Map<String,dynamic>json)
 {
    String image=json['image']?? json['emotion_image'] ?? "None";
    String fullImagePath=constants.BaseURL+image;
    return MoodModel(Description: json['description'],
     ImagePath: fullImagePath, 
     Text:json['name'] ?? json["mood"]?? "None",
     count: json["count"],
     );
 }
}
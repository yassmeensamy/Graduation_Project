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
     String fullImagePath = "${constants.BaseURL}{json['image']}";
    return MoodModel(Description: json['description'],
     ImagePath: fullImagePath, 
     Text:json['name'] ?? json["mood"],
     count: json["count"],
     );
 }
}
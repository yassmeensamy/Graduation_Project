class MoodModel 
{
final String Text;
final String? Description;
final String? ImagePath;
 MoodModel ({required this.Description,required this.ImagePath ,required this.Text});
 
 factory MoodModel.fromJson(Map<String,dynamic>json, String baseUrl)
 {
     String fullImagePath = "$baseUrl${json['image']}";
    return MoodModel(Description: json['description'], ImagePath: fullImagePath, Text:json['name']);
 }
}
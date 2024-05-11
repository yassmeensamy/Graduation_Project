class SecondMoodModel 
{
final String Text;
final String Description;
final String ImagePath;
 SecondMoodModel ({required this.Description,required this.ImagePath ,required this.Text});
 
 factory SecondMoodModel.fromJson(Map<String,dynamic>json, String baseUrl)
 {
     String fullImagePath = "$baseUrl${json['image']}";
    return SecondMoodModel(Description: json['description'], ImagePath: fullImagePath, Text:json['name']);
 }
}
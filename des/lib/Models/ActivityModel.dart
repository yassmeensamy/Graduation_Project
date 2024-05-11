
class ActivityModel
{
final String Text;
final String ImagePath;

 ActivityModel({required this.ImagePath ,required this.Text});
 factory  ActivityModel.fromjson(Map<String,dynamic>json)
 {
   return  ActivityModel(ImagePath: json["activity_image"], Text:json[ "activity_text"]);
 }
}

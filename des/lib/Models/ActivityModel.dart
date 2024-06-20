
class ActivityModel
{
final String Text;
final String? ImagePath;
final num? Count;

 ActivityModel({required this.ImagePath ,required this.Text ,this.Count});
 factory  ActivityModel.fromjson(Map<String,dynamic>json)
 {
   return  ActivityModel(
    ImagePath: json["activity_image"],
    Text:json[ "activity_text"]?? json["activity"]?? "None",
    Count: json["count"]);
 }
}


class ReasonModel
{
final String Text;
final String ImagePath;

 ReasonModel({required this.ImagePath ,required this.Text});
 factory  ReasonModel.fromjson(Map<String,dynamic>json)
 {
   return ReasonModel(ImagePath: json["reason_image"], Text:json[ "reason_text"]);
 }
}

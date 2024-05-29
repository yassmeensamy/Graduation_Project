
class CalenderModel 
{
  String SelectedMood;
  String ImageMood;
  String dateEntery;
  
  CalenderModel({
    required this.SelectedMood,
    required this.ImageMood,
    required this.dateEntery,
  });
  factory CalenderModel.fromJson(Map<String,dynamic>json)
  {
    return CalenderModel(SelectedMood: json['mood']?? 'Null', ImageMood: json['emotion_image'], dateEntery: json['date']);
  }
}
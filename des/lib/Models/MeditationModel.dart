
class MeditationModel
{
   final String MeditationName;
   final String MeditationImage;
   final String MeditationURl;
   String duration;
   MeditationModel({

     required this.MeditationName,
    required this.MeditationImage,
    required this.MeditationURl, 
    required this.duration,
   }
   );
    factory MeditationModel.fromJson(Map<String, dynamic> json)
    {
      return MeditationModel(
      MeditationName: json['name'] ,
      MeditationImage: json['image'] ,
      MeditationURl:json['url'],
      duration: json['duration'],
    );
    }
}
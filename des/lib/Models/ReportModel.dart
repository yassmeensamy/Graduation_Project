import 'package:des/Models/ActivityModel.dart';
import 'package:des/Models/MoodModel.dart';
import 'package:des/Models/ReasonModel.dart';

class ReportModel
{

  MoodModel primarymood;
  MoodModel Secondmood;
  List<ActivityModel> activities;
  List<ReasonModel> reasons;
  String? journaling;
  String? stressTip;
  String? dayTip;
  ReportModel({
    
    required this.primarymood,
    required this.Secondmood,
    required this.activities,
    required this.reasons,
     this.journaling,
     this.stressTip,
     this.dayTip,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) 
  {

     MoodModel primarymood= MoodModel.fromJson(json["primary_mood"]??null);
     MoodModel  Secondmood=MoodModel.fromJson(json["secondary_mood"]??null);
     List<dynamic> activities=json["activity"]?? [];
      final Activitylist= activities.map((item)
      { 
        return ActivityModel.fromjson(item);
      }).toList();
      List<dynamic>reasons=json["reason"]?? [];
      final Reasonlist= reasons.map((item)
      { 
        return ReasonModel.fromjson(item);
      }).
      toList();
      
      return ReportModel(
      primarymood: primarymood,
      Secondmood: Secondmood,
      activities: Activitylist,
      reasons:Reasonlist,
      journaling: json['note'] ?? "None",
      stressTip: json['stress_tip'] ??"None",
      dayTip: json['tip_of_the_day']?? "None",
    );
  }
}
import 'package:des/Models/WeeklyModel.dart';

class WeeklyHistoryModel {
  bool is7DaysAgo;
  Map<String, List<WeelklyModel>> history;
  WeeklyHistoryModel({
    required this.is7DaysAgo,
    required this.history,
  });

factory WeeklyHistoryModel.fromJson(Map<String, dynamic> json) {
  Map<String,dynamic> historyJson = json['history']; //done
  Map<String, List<WeelklyModel>> history = {};
  historyJson.forEach((key, value)
   {
    print(value.runtimeType);
     final plans = (value as List).map((e) {
      return WeelklyModel.fromJson(e);
    }).toList(); // convert the Iterable to List

   
    history[key] = plans;
  });
  
  
  return WeeklyHistoryModel(
    is7DaysAgo: json['is_7_days_ago'] ,
    history:history,
  );
}
}

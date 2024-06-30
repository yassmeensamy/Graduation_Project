import 'dart:convert';

import 'package:des/Api/Api.dart';
import 'package:des/Models/ActivityModel.dart';
import 'package:des/Models/MoodModel.dart';
import 'package:des/Models/WeeklyHistory.dart';
import 'package:des/Models/WeeklyModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '/constants.dart' as constants;
import '../../Models/TestResultModel.dart';
part 'insigths_state.dart';




class InsigthsCubit extends Cubit<InsigthsState> {

  WeeklyHistoryModel? weeklyHistoy = null;
  bool is7DaysAgo=false ;
  List<MoodModel> MoodHistory = [];
  List<ActivityModel> AcivityMonthHistory = [];
  List<ActivityModel> AcivityYearHistory = [];
  List<TestResultModel> DepressionHistoy = [];
  Map<String, List<WeelklyModel>> results={};
  InsigthsCubit() : super(InsightLoading()) ;

  String extractDayAndMonth(String timestampString) 
  {
    DateTime timestamp = DateTime.parse(timestampString).toLocal();
    String monthName = DateFormat('MMM').format(timestamp);
    String day = timestamp.day.toString();
    return "$day $monthName";
  }
  Future<List<MoodModel>> fetchMoodHistory() async {
   try{
      Response response = await Api().get(url: "${constants.BaseURL}/api/emotion-count/");
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        MoodHistory = data.map((e) => MoodModel.fromJson(e)).toList();
        return MoodHistory;
      } else {
        return [];
      }
    } 
    catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }
  Future<List<ActivityModel>> fetchActivitiesYearHistory() async {
  
    try {
        Response response =await Api().get(url: "${constants.BaseURL}/api/activity-count/");
       if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        AcivityYearHistory = data.map((e) => ActivityModel.fromjson(e)).toList();
          return AcivityYearHistory;
      } 
      else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }
  Future<List<ActivityModel>> fetchActivitiesMonthHistory() async {
    try {
       Response response =await Api().get(url: "${constants.BaseURL}/api/activity-count-this-month/");
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        AcivityMonthHistory =
            data.map((e) => ActivityModel.fromjson(e)).toList();
        return AcivityMonthHistory;
      } else {
        return [];
      }
    } 
    catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }
  Future<List<TestResultModel>> fetchDepressionTestHistory() async {
    try {
        Response response = await Api() .get(url: "${constants.BaseURL}/api/test-history/");
        if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        DepressionHistoy = data.map((item) => TestResultModel.fromJson(item)) .toList() .reversed .toList();
              DepressionHistoy.forEach((result) 
              {
                     result.timestamp = extractDayAndMonth(result.timestamp!);
                 });
                  return DepressionHistoy;
      } 
      else 
      {
        throw Exception('Failed to load test history');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }
  Future<WeeklyHistoryModel> fetchWeeklyHistory() async {
    //emit(HomeLoading() as InsigthsState);
    try {
     
       Response response = await Api().get(url: "${constants.BaseURL}/api/life-record-history/");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        weeklyHistoy = WeeklyHistoryModel.fromJson(data);
        results = weeklyHistoy!.history;
        is7DaysAgo=weeklyHistoy!.is7DaysAgo;
        // خلي بالك من الحته دي  ان ممكن نحتاجها قدام انا خدت ممنها الشهر واليوم بس
        results.forEach((key, value) 
        {
          value.forEach((item) {
            item.timestamp = extractDayAndMonth(item.timestamp!);
          });
        });
         
        return weeklyHistoy!;
      } 
      else 
      {
        throw Exception('Failed to load test history');
      }
    } 
    catch (e) 
    {
     
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<void> loadInsights() async 
  {
    emit(InsightLoading());
    try {
      weeklyHistoy = await fetchWeeklyHistory();
      DepressionHistoy = await fetchDepressionTestHistory();
      AcivityYearHistory = await fetchActivitiesYearHistory();
      AcivityMonthHistory = await fetchActivitiesMonthHistory();
      MoodHistory = await fetchMoodHistory();
      emit(InsightLoaded(DepressionHistoy, weeklyHistoy!, AcivityYearHistory,
          AcivityMonthHistory, MoodHistory));
    } catch (e) {
      emit(InsightError('Failed to fetch data: ${e.toString()}'));
    }
  }
  List<WeelklyModel> SearchAboutCategoty(String Category) {
    if (weeklyHistoy!.history.containsKey(Category)) {
      List<WeelklyModel> results = weeklyHistoy!.history[Category]!;
      return results;
    } else {
      return [];
    }
  }
  Future<void> ResetInsigth() async
  {
         fetchActivitiesMonthHistory();
         fetchActivitiesYearHistory();
         fetchMoodHistory();
  }

}




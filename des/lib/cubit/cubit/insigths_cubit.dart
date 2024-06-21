import 'dart:convert';

import 'package:des/Models/ActivityModel.dart';
import 'package:des/Models/MoodModel.dart';
import 'package:des/Models/WeeklyHistory.dart';
import 'package:des/Models/WeeklyModel.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import 'package:shared_preferences/shared_preferences.dart';
import '/constants.dart' as constants;
import '../../Models/TestResultModel.dart';

part 'insigths_state.dart';

class InsigthsCubit extends Cubit<InsigthsState> 

{
 
  late WeeklyHistoryModel weeklyhistoy;
  InsigthsCubit() : super(InsigthsInitial()) {
    loadInsights();
  }

  String extractDayAndMonth(String timestampString) 
  { 
    DateTime timestamp = DateTime.parse(timestampString).toLocal();
    String monthName = DateFormat('MMM').format(timestamp);
    String day = timestamp.day.toString();
    return "$day $monthName";
  }
  Future<List<MoodModel>> fetchMoodHistory() async 
  { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    print(accessToken);
    try {
      Map<String, String> headers = 
      {
        'Authorization':
            'Bearer $accessToken',
      };
      var response= await http.get(Uri.parse("${constants.BaseURL}/api/emotion-count/"),headers:headers);
      if(response.statusCode==200)
      {
       List<dynamic> data= jsonDecode(response.body);
       print("moodhistory done");
        return data.map((e) => MoodModel.fromJson(e)).toList();
      }
      else 
      {
        return [];
      }
    }
    catch(e)
    {
       throw Exception('Failed to fetch data: ${e.toString()}');
    }
              
  }
  Future<List<ActivityModel>> fetchActivitiesYearHistory() async 
  { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    print(accessToken);
    try {
      Map<String, String> headers = 
      {
        'Authorization':
            'Bearer $accessToken',
      };

      var response= await http.get(Uri.parse("${constants.BaseURL}/api/activity-count/"),headers:headers);
      if(response.statusCode==200)
      {
       List<dynamic> data= jsonDecode(response.body);
        return data.map((e) => ActivityModel.fromjson(e)).toList();
      
      }
      else 
      {
        return [];
      }
    }
    catch(e)
    {
       throw Exception('Failed to fetch data: ${e.toString()}');
    }
              
  }
  
  Future<List<ActivityModel>> fetchActivitiesMonthHistory() async 
  { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    print(accessToken);
    try {
      Map<String, String> headers = 
      {
        'Authorization':
            'Bearer $accessToken',
      };

      var response= await http.get(Uri.parse("${constants.BaseURL}/api/activity-count-this-month/"),headers:headers);
      if(response.statusCode==200)
      {
       List<dynamic> data= jsonDecode(response.body);
       print("monthDone");
        return data.map((e) => ActivityModel.fromjson(e)).toList();
      
      }
      else 
      {
        return [];
      }
    }
    catch(e)
    {
       throw Exception('Failed to fetch data: ${e.toString()}');
    }
              
  }

  Future<List<TestResultModel>> fetchDepressionTestHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    try {
      Map<String, String> headers = {
        'Authorization':
            'Bearer $accessToken',
        // Add any other headers if needed
      };
      var response = await http.get(
        Uri.parse(
          "${constants.BaseURL}/api/test-history/",
        ),
        headers: headers,
      );

      if (response.statusCode == 200) 
      {
        List<dynamic> data = jsonDecode(response.body);
        return data
            .map((item) => TestResultModel.fromJson(item))
            .toList()
            .reversed
            .toList();
      } 
      else {
        throw Exception('Failed to load test history');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }
  
  Future<WeeklyHistoryModel> fetchWeeklyHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    try {
      
      Map<String, String> headers = {
        'Authorization':
            'Bearer $accessToken',
      };
      
      var response = await http.get(
        Uri.parse(
          "${constants.BaseURL}/api/life-record-history/",
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {

         Map<String, dynamic> data = jsonDecode(response.body);
         weeklyhistoy= WeeklyHistoryModel.fromJson(data); 
        Map<String, List<WeelklyModel>> results =weeklyhistoy.history;
      // خلي بالك من الحته دي  ان ممكن نحتاجها قدام انا خدت ممنها الشهر واليوم بس
         results.forEach((key, value)
          {
            value.forEach((item) 
            {
                item.timestamp = extractDayAndMonth(item.timestamp!);
             });
          
         });
            return  weeklyhistoy;
      } 
      else 
      {
        throw Exception('Failed to load test history');
      }
    } catch (e) 
    {
      print(e);
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }


  Future<void> loadInsights() async {
    emit(InsightLoading());
    try {
      var testHistory = await fetchDepressionTestHistory();
      testHistory.forEach((result) 
      {
        result.timestamp = extractDayAndMonth(result.timestamp!);
       });
       var  Weeklyhistory=await fetchWeeklyHistory();
      
       var ActivitiesYearHistory=   await fetchActivitiesYearHistory();
       var ActivitiesMonthHistory=   await fetchActivitiesMonthHistory();
       var MoodHistory= await fetchMoodHistory();
       emit(InsightLoaded(testHistory ,Weeklyhistory,ActivitiesYearHistory,ActivitiesMonthHistory,MoodHistory));
    }  
    catch (e) {
      emit(InsightError('Failed to fetch data: ${e.toString()}'));
    }
  }





  List<WeelklyModel> SearchAboutCategoty(String Category)
  {
    print(weeklyhistoy.history.length);
    if (weeklyhistoy.history.containsKey(Category)) 
    {
      List<WeelklyModel> results =weeklyhistoy.history[Category]!;
      return  results;
    }
   else 
   {
    print("Category $Category not found.");
    return [];
   }
 }


  }


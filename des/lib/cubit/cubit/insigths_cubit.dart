import 'dart:convert';
import 'dart:io';
import 'package:des/Models/WeeklyHistory.dart';
import 'package:des/Models/WeeklyModel.dart';
import 'package:des/Models/WeeklyToDoModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/TestResultModel.dart';

part 'insigths_state.dart';

class InsigthsCubit extends Cubit<InsigthsState> 

{
 
  late WeeklyHistoryModel weeklyhistoy;
  InsigthsCubit() : super(InsigthsInitial()) {
    loadInsights();
  }

  String extractDayAndMonth(String timestampString) {
    DateTime timestamp = DateTime.parse(timestampString);
    String monthName = DateFormat('MMM').format(timestamp);
    String day = timestamp.day.toString();
    return "$day $monthName";
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
          "http://157.175.185.222/api/test-history/",
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data
            .map((item) => TestResultModel.fromJson(item))
            .toList()
            .reversed
            .toList();
      } else {
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
      /*
      Map<String, String> headers = {
        'Authorization':
            'Bearer $accessToken',
      };
      */
       Map<String, String> headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2MjUwMjg1LCJpYXQiOjE3MTAyNTAyODUsImp0aSI6IjQ2YTg5NWE2ZjBmZDRlMGViNTRlNTk1MDIyMDJiNjg5IiwidXNlcl9pZCI6MX0.mTx7JXgwDzp1N7H9yd5xcKDa92WMK-T_S_PnwWX7vGI',
      };
      var response = await http.get(
        Uri.parse(
          "http://157.175.185.222/api/life-record-history/",
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
       print("second");
       emit(InsightLoaded(testHistory ,Weeklyhistory));
    } catch (e) {
      emit(InsightError('Failed to fetch data: ${e.toString()}'));
    }
  }





  List<WeelklyModel> SearchAboutCategoty(String Category)
  {
    print(weeklyhistoy.history.length);
    if (weeklyhistoy.history.containsKey(Category)) 
    {
      List<WeelklyModel> results =weeklyhistoy.history[Category]!;
      print("Results for $Category:");
      return  results;
    }
   else 
   {
    print("Category $Category not found.");
    return [];
   }
 }


  }


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

class InsigthsCubit extends Cubit<InsigthsState> {
  WeeklyHistoryModel? weeklyHistoy = null;
  List<MoodModel> MoodHistory = [];
  List<ActivityModel> AcivityMonthHistory = [];
  List<ActivityModel> AcivityYearHistory = [];
  List<TestResultModel> DepressionHistoy = [];
  InsigthsCubit() : super(InsightLoading()) ;




  String extractDayAndMonth(String timestampString) {
    DateTime timestamp = DateTime.parse(timestampString).toLocal();
    String monthName = DateFormat('MMM').format(timestamp);
    String day = timestamp.day.toString();
    return "$day $monthName";
  }

  Future<List<MoodModel>> fetchMoodHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var response = await http.get(
          Uri.parse("${constants.BaseURL}/api/emotion-count/"),
          headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        MoodHistory = data.map((e) => MoodModel.fromJson(e)).toList();
        return MoodHistory;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<List<ActivityModel>> fetchActivitiesYearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };

      var response = await http.get(
          Uri.parse("${constants.BaseURL}/api/activity-count/"),
          headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        AcivityYearHistory =
            data.map((e) => ActivityModel.fromjson(e)).toList();
        return AcivityYearHistory;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<List<ActivityModel>> fetchActivitiesMonthHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var response = await http.get(
          Uri.parse("${constants.BaseURL}/api/activity-count-this-month/"),
          headers: headers);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        // Add any other headers if needed
      };
      var response = await http.get(
        Uri.parse(
          "${constants.BaseURL}/api/test-history/",
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        DepressionHistoy = data
            .map((item) => TestResultModel.fromJson(item))
            .toList()
            .reversed
            .toList();
              DepressionHistoy.forEach((result) 
              {
                     result.timestamp = extractDayAndMonth(result.timestamp!);
        });
        return DepressionHistoy;
      } else {
        throw Exception('Failed to load test history');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<WeeklyHistoryModel> fetchWeeklyHistory() async {
    //emit(HomeLoading() as InsigthsState);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };

      var response = await http.get(
        Uri.parse(
          "${constants.BaseURL}/api/life-record-history/",
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        weeklyHistoy = WeeklyHistoryModel.fromJson(data);
        Map<String, List<WeelklyModel>> results = weeklyHistoy!.history;
        // خلي بالك من الحته دي  ان ممكن نحتاجها قدام انا خدت ممنها الشهر واليوم بس
        results.forEach((key, value) 
        {
          value.forEach((item) {
            item.timestamp = extractDayAndMonth(item.timestamp!);
          });
        });
        
        print("weekly:${weeklyHistoy!.history.length}");
        return weeklyHistoy!;
      } else {
        throw Exception('Failed to load test history');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<void> loadInsights() async {
   
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

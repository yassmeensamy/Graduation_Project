import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/TestResultModel.dart';

part 'insigths_state.dart';

class InsigthsCubit extends Cubit<InsigthsState> {
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

  Future<void> loadInsights() async {
    emit(InsightLoading());
    try {
      var testHistory = await fetchDepressionTestHistory();
      testHistory.forEach((result) {
        result.timestamp = extractDayAndMonth(result.timestamp!);
      });
      emit(InsightLoaded(testHistory));
    } catch (e) {
      emit(InsightError('Failed to fetch data: ${e.toString()}'));
    }
  }
}

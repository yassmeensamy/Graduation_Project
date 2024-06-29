import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Models/MoodModel.dart';
import 'package:des/Models/ReportModel.dart';
import 'package:des/cubit/EmotionCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; 
import '/constants.dart' as constants;
part 'handle_emojy_daily_state.dart';

class HandleEmojyDailyCubit extends Cubit<HandleEmojyDailyState> 
{
  final SecondLayerCubit moodCubit;
   List<MoodModel> primaryEmotions=[];
   ReportModel? dailyReport = null;
  Map<String,ReportModel> reportHistory={};
  HandleEmojyDailyCubit({required this.moodCubit}) : super(HandleEmojyDailyloading());
  Future<void> loadData() async 
  {
     emit(HandleEmojyDailyloading());
    primaryEmotions = await moodCubit.GetPrimaryEmotions(); 
    await chechMoodEnrty();
  }

Future<Map<String,ReportModel>> ReportHistory() async 
   {
    try {
       Response response = await Api().get(url: "${constants.BaseURL}/api/report-month/",);
      if (response.statusCode == 200) 
      {
        Map<String, ReportModel> reportHistory = {};
        dynamic responseData = jsonDecode(response.body);
        responseData.forEach((key, value) 
        {
          reportHistory[key] = ReportModel.fromJson(value); 
        });
        return reportHistory;
      } 
      else
       {
         return {};
      }
    } 
    catch (e) 
    {
      return {};
    }
  }
  
Future<void> chechMoodEnrty() async 
{
   reportHistory= await ReportHistory();
  if(reportHistory.containsKey(DateFormat('y-MM-dd').format(DateTime.now())))
  {
    dailyReport=reportHistory[DateFormat('y-MM-dd').format(DateTime.now())];
                emit(HandleReportloaded(dailyReport!));
            
  }
  else 
   {             
               emit(HandleEmojyloaded(primaryEmotions));
   } 
}

Future<void>  DeleteEntryToday(BuildContext context) async
  {
    try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
     Map<String, String> headers =
      {
      'Authorization':
          'Bearer $accessToken'
      };
      print(accessToken);
    final response = await http.delete(
      Uri.parse("${constants.BaseURL}/api/delete-user-input-today/"),
      headers: headers,
    );
    if (response.statusCode == 204) 
    {
      print("Deleted Done");
       moodCubit.EmptyData();
       //await BlocProvider.of<InsigthsCubit>(context).loadInsights();
       emit( HandleEmojyloaded(primaryEmotions));
    }  
    else 
    {
      print(response.statusCode); 
    }
  } 
  catch (e) 
  { 
    print("error${e}");
  }
}
void FinishEntry(ReportModel report ,BuildContext context)
{
    emit(HandleReportloaded(dailyReport!));
}
}

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:des/Models/CalenderModel.dart';
import 'package:des/Models/MoodModel.dart';
import 'package:des/Models/ReportModel.dart';
import 'package:des/Models/WeeklyToDoModel.dart';
import 'package:des/cubit/EmotionCubit.dart';
import 'package:des/cubit/cubit/cubit/weekly_cubit.dart';
import '/constants.dart' as constants;
import 'package:des/cubit/cubit/insigths_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
part 'handle_home_state.dart';

class HandleHomeCubit extends Cubit<HandleHomeState> 
{

  final SecondLayerCubit moodCubit;
  final InsigthsCubit insigthsCubit;
  final WeeklyCubit weeklyCubit;
  bool isEntry=false;
  List<MoodModel> primaryEmotions=[];
  List<WeeklyToDoPlan>WeeklyToDo=[];
  HandleHomeCubit({ required this.moodCubit , required this.insigthsCubit ,required this.weeklyCubit}) : super(HandleHomeInitial())
  {
    initialize();
  }
  void initialize()
  {
     loadHomeData();  
  }

  void loadHomeData() async 
  {
    emit(HomeLoading());
    try 
    {
      primaryEmotions = await moodCubit.GetPrimaryEmotions();
      await GetWeeklyToDo();
      //await chechMoodEnrty();
      print("yasmmenn ashter katkot");
      emit(HomeLoaded(primaryEmotions ,WeeklyToDo));
    } 
    catch (e) {
      emit(HomeError('Failed to load data: $e'));
    }
  }

  Future<void>  MoodHistory() async
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
    final response = await http.get(
      Uri.parse("${constants.BaseURL}/api/current-month-moods/"),
      headers: headers,
    );
    if (response.statusCode == 200) 
    {
      List<dynamic> responseData = jsonDecode(response.body);
      List<CalenderModel>moodhistory=(responseData).map((item) =>CalenderModel.fromJson(item)).toList();
    } 
    else 
    {
      print(response.statusCode); 
    }
  } 
  catch (e) 
  { 
    print(e);
  }
}

void RemoveFromToDoList(int ActivityId ) async
{
  if (await CheckActivity(ActivityId)==true)
  {
  WeeklyToDo.removeWhere((item) => item.id == ActivityId);
  
  }
  emit(HomeLoaded(primaryEmotions, WeeklyToDo));  
}

Future<bool> chechMoodEnrty() async 
{
  print("loloooy");
  Map<String,ReportModel> reportHistory= await ReportHistory();
  if(reportHistory.containsKey(DateFormat('y-MM-dd').format(DateTime.now())))
  {
    return true;
  }
  else 
  { 
    return  false ;
  }
}
Future <bool>CheckActivity(int ActivityId) async
{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String ?accessToken = prefs.getString('accessToken');
     Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken'
    };
    print(ActivityId);
    String baseUrl="${constants.BaseURL}/api/check-activity/";
    String Url=baseUrl+ActivityId.toString()+"/";
    http.Response response= await http.patch(Uri.parse(Url),headers: headers );
    if(response.statusCode==200)
    {
      isEntry=true;
       return true;
    }
    else 
    {
          isEntry=false;
             return false ;
    }


}

Future<void> GetWeeklyToDo() async
{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ?accessToken = prefs.getString('accessToken');
    
    Map<String, String> headers = 
    {
      'Authorization': 'Bearer $accessToken',
    };
    
   
    http.Response response = await http.get(
      Uri.parse(
        "${constants.BaseURL}/api/unchecked-activities/",
      ),
      headers: headers,
    );
    if(response.statusCode==200)
    {
       List<dynamic> responseData = jsonDecode(response.body);
       WeeklyToDo = (responseData).map((item) =>WeeklyToDoPlan.fromJson(item)).toList();
       print("weekly done");

    }
    else 
    {
      print(response.statusCode); 
    }
}
   void resetState() 
   {
     emit(HomeLoaded(primaryEmotions,WeeklyToDo));
   }

   Future<Map<String,ReportModel>> ReportHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken'
      };
      
      final response = await http.get(
        Uri.parse("${constants.BaseURL}/api/report-month/"),
        headers: headers,
      );
      
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

  Future<void>  DeleteEntryToday() async
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
      Uri.parse("${constants.BaseURL}}/api/delete-user-input-today/"),
      headers: headers,
    );
    if (response.statusCode == 200) 
    {
      isEntry=false;
      print("Deleted Done");
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
}

class CheckboxCubit extends Cubit<bool> {
  CheckboxCubit() : super(false);

  void toggleCheckbox(bool newValue) => emit(newValue);
}
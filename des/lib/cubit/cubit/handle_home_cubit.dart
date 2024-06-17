import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:des/Models/CalenderModel.dart';
import 'package:des/Models/PrimaryEmotionsModel.dart';
import 'package:des/Models/WeeklyToDoModel.dart';
import 'package:des/cubit/EmotionCubit.dart';
import 'package:des/cubit/cubit/cubit/weekly_cubit.dart';

import 'package:des/cubit/cubit/insigths_cubit.dart';
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
  List<CalenderModel>moodhistory=[];
  List<PrimaryMoodModel> primaryEmotions=[];
  List<WeeklyToDoPlan>WeeklyToDo=[];
  HandleHomeCubit({required this.moodCubit , required this.insigthsCubit ,required this.weeklyCubit}) : super(HandleHomeInitial())
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
      await moodCubit.GetPrimaryEmotions();
      primaryEmotions = moodCubit.primaryEmotions;
      await MoodHistory();
      await GetWeeklyToDo();
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
     print(accessToken);
    //String ? accessToken ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2MjUwMjg1LCJpYXQiOjE3MTAyNTAyODUsImp0aSI6IjQ2YTg5NWE2ZjBmZDRlMGViNTRlNTk1MDIyMDJiNjg5IiwidXNlcl9pZCI6MX0.mTx7JXgwDzp1N7H9yd5xcKDa92WMK-T_S_PnwWX7vGI";
     Map<String, String> headers =
      {
      'Authorization':
          'Bearer $accessToken'
      };
    final response = await http.get(
      Uri.parse("http://157.175.185.222/api/current-month-moods/"),
      headers: headers,
    );
    if (response.statusCode == 200) 
    {
      List<dynamic> responseData = jsonDecode(response.body);
      moodhistory = (responseData).map((item) =>CalenderModel.fromJson(item)).toList();
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

bool chechMoodEnrty()
{
  //time now is DateFormat('yyyy-MM-dd').format(DateTime.now());
   print( DateFormat('d').format(DateTime.now()));
   if(moodhistory[int.parse(DateFormat('d').format(DateTime.now()))].SelectedMood!="Null")  //معناها انه هلاص دخل
   {
       print(moodhistory[int.parse(DateFormat('d').format(DateTime.now()))].SelectedMood!);
        return true;
   }
   else 
   {
    print(moodhistory[int.parse(DateFormat('d').format(DateTime.now()))].SelectedMood!);
    return false;
   }  
}
Future <bool>CheckActivity(int ActivityId) async
{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String ?accessToken = prefs.getString('accessToken');
     Map<String, String> headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2MjUwMjg1LCJpYXQiOjE3MTAyNTAyODUsImp0aSI6IjQ2YTg5NWE2ZjBmZDRlMGViNTRlNTk1MDIyMDJiNjg5IiwidXNlcl9pZCI6MX0.mTx7JXgwDzp1N7H9yd5xcKDa92WMK-T_S_PnwWX7vGI',
    };
    /*
    Map<String, String> headers = 
    {
      'Authorization': 'Bearer $accessToken',
    };
    */
    String baseUrl="http://157.175.185.222/api/check-activity/";
    String Url=baseUrl+ActivityId.toString()+"/";
    http.Response response= await http.patch(Uri.parse(Url),headers: headers );
    if(response.statusCode==200)
    {
       print("activity done");
       return true;
    }
    else 
    {

             print("activity not found");
             return false ;
    }


}

Future<void> GetWeeklyToDo() async
{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ?accessToken = prefs.getString('accessToken');
    /*
    Map<String, String> headers = 
    {
      'Authorization': 'Bearer $accessToken',
    };
    */
     Map<String, String> headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2MjUwMjg1LCJpYXQiOjE3MTAyNTAyODUsImp0aSI6IjQ2YTg5NWE2ZjBmZDRlMGViNTRlNTk1MDIyMDJiNjg5IiwidXNlcl9pZCI6MX0.mTx7JXgwDzp1N7H9yd5xcKDa92WMK-T_S_PnwWX7vGI',
    };
    http.Response response = await http.get(
      Uri.parse(
        "http://157.175.185.222/api/unchecked-activities/",
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
   
}

class CheckboxCubit extends Cubit<bool> {
  CheckboxCubit() : super(false);

  void toggleCheckbox(bool newValue) => emit(newValue);
}
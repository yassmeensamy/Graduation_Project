import 'dart:convert';
import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:des/Models/CalenderModel.dart';
import 'package:des/Models/PrimaryEmotionsModel.dart';
import 'package:des/cubit/EmotionCubit.dart';
import 'package:des/cubit/cubit/home_cubit.dart';
import 'package:des/cubit/cubit/insigths_cubit.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
part 'handle_home_state.dart';

class HandleHomeCubit extends Cubit<HandleHomeState> {
  final SecondLayerCubit moodCubit;
  final InsigthsCubit insigthsCubit;
  List<CalenderModel>moodhistory=[];
   List<PrimaryMoodModel> primaryEmotions=[];
  HandleHomeCubit({required this.moodCubit , required this.insigthsCubit}) : super(HandleHomeInitial())
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
    try {
      await moodCubit.GetPrimaryEmotions();
      primaryEmotions = moodCubit.primaryEmotions;
      await MoodHistory();
      emit(HomeLoaded(primaryEmotions));
    } catch (e) {
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
   void resetState() 
   {
     emit(HomeLoaded(primaryEmotions));
   }
}


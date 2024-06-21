import 'dart:convert';

import 'package:des/Models/ReportModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ActivityModel.dart';
import '../constants.dart' as constants;
import '../Models/ReasonModel.dart';
import '../Models/MoodModel.dart';
import 'EmotionCubitState.dart';

class SecondLayerCubit extends Cubit<SecondLayerCubitCubitState> {
  SecondLayerCubit() : super(EmotionCubitStateIntial ())
  {  
  }
  List<MoodModel> secondEmotions = [];
   List<MoodModel> primaryEmotions=[];
  List<Map<String, String>> ActivitiesSelected=[];
  List<Map<String, String>> ReasonSelected=[];
    String SelectedMood=" ";
    String EmotionType=" " ;
    String ImagePath=" ";


Future<List<MoodModel>> GetPrimaryEmotions() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
     Map<String, String> headers = {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    final response = await http.get(
      Uri.parse("${constants.BaseURL}/api/primary-emotions/"),
      headers: headers,
    );
    if (response.statusCode == 200) 
    {
      List<dynamic> responseData = jsonDecode(response.body);
       return primaryEmotions = (responseData).map((item) =>MoodModel.fromJson(item)).toList();
    } 
    else 
    {
       return [];
     
    }
  } 
  catch (e) 
  { 
    
   return [];
  }
}

Future<void> SavePrimaryEmotions(String SelectedMood) async
{
    var data={"mood":SelectedMood};
    var json_data=jsonEncode(data); 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    print(accessToken);
   Map<String, String> headers = 
   {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' 
    };
    Response response=await http.post(Uri.parse("${constants.BaseURL}/api/mood-primary-entry/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==200)
     {
          dynamic responseData = jsonDecode(response.body);     
     }
      else 
      {
          emit(EmotionCubitStateFailur("Request failed with status: ${response.statusCode}"));
      }
}
Future<void> getSecondEmotions(String type,String imagePath) async
   {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    Map<String, String> headers = {
      'Authorization':
        'Bearer $accessToken'
      ,'Content-Type': 'application/json' 
    };

    try {
      var data = {'type': type};
      var jsonData = jsonEncode(data); 
      var response = await http.post(
        Uri.parse("${constants.BaseURL}/api/emotions/"), 
        body: jsonData,
        headers: headers,
        );
      if (response.statusCode == 200) 
      {
         List<dynamic> responseData = jsonDecode(response.body);
         secondEmotions = responseData.map((item) => MoodModel.fromJson(item, )).toList();
        if (secondEmotions.isNotEmpty) 
        { 
           EmotionType=type;
           ImagePath=imagePath;

          emit(EmotionCubitStateSucess(secondEmotions,imagePath,type));
        } 
        else 
        {
          emit(EmotionCubitStateFailur("No data available"));
        }
      } 
      else {
        emit(EmotionCubitStateFailur("Request failed with status: ${response.statusCode}"));
      }
    } 
    catch (e) 
    {
      emit(EmotionCubitStateFailur(e.toString()));
    }
  }

Future<void> SaveSecondEmotions() async
{
    var data={"mood":SelectedMood};
    var json_data=jsonEncode(data); 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
   Map<String, String> headers = 
   {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    Response response=await http.post(Uri.parse("${constants.BaseURL}/api/mood-second-entry/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==200)
     {
          dynamic responseData = jsonDecode(response.body);
     }
      else 
      {
          emit(EmotionCubitStateFailur("Request failed with status: ${response.statusCode}"));
      }

}


Future<void> GetActivitiesandReason() async {
  List<ActivityModel> activities = [];
  List<ReasonModel> Reasons = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
  Map<String, String> headers = 
       {
      'Authorization':
      'Bearer $accessToken'
     ,'Content-Type': 'application/json' // You don't need this header for this request
       };
  Response response1 = await http.get(
    Uri.parse("${constants.BaseURL}/api/activities/"),
    headers: headers,
  );
  if (response1.statusCode == 200) 
  {
    List<dynamic> responseData1 = jsonDecode(response1.body);
    activities = responseData1.map((item) => ActivityModel.fromjson(item)).toList();
  } 
  else 
  {
    emit(EmotionCubitStateFailur("Request failed with status: ${response1.statusCode}"));
    return;
  }

  Response response2 = await http.get(
    Uri.parse("${constants.BaseURL}/api/reasons/"),
    headers: headers,
  );

  if (response2.statusCode == 200)
   {
    List<dynamic> responseData2 = jsonDecode(response2.body);
    Reasons = responseData2.map((item) => ReasonModel.fromjson(item)).toList();
    //print(Reasons);
     emit(Activities_ReasonsState(activities,Reasons)); 
  } 
  else
   {
    emit(EmotionCubitStateFailur("Request failed with status: ${response2.statusCode}"));
    return;
  }


}

Future<void>SendJournaling(String note)
async {
  print(note);
  var data={"notes":note};
  var json_data=jsonEncode(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');

   Map<String, String> headers = {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    Response response=await http.post(Uri.parse("${constants.BaseURL}/api/journal-entry/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==200)
     {
      
         dynamic responseData = jsonDecode(response.body);
         print("journaling done");
         ReportModel? reportModel=await GetDailyReport();
         emit(conclusionState(reportModel!));     
     }
      else 
      { 
          print(response.statusCode);
          emit(EmotionCubitStateFailur("Request failed with status: ${response.statusCode}"));
      }


}

Future<void> SaveReason() async
{
    var data={"reasons":ReasonSelected};
    var json_data=jsonEncode(data); 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
   Map<String, String> headers = 
   {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    Response response=await http.post(Uri.parse("${constants.BaseURL}/api/reason-entries/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==201)
     {
          dynamic responseData = jsonDecode(response.body);
     }
      else 
      {
          emit(EmotionCubitStateFailur("Request failed with status: ${response.statusCode}"));
      }

}

Future<void> SaveActivity() async
{
    var data={"activities":ActivitiesSelected};
    var json_data=jsonEncode(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
   Map<String, String> headers = 
   {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    Response response=await http.post(Uri.parse("${constants.BaseURL}/api/activity-entries/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==201)
     {
          dynamic responseData = jsonDecode(response.body);
     }
      else 
      { 
          emit(EmotionCubitStateFailur("Request failed with status: ${response.statusCode}"));
      }

}



 
void StoreActivity(String activity)
{
  Map<String, String> newActivity = {"activity": activity};
  ActivitiesSelected.add(newActivity);
}

void StoreReason(String Reason)
{
  Map<String, String> newReason = {"reason": Reason};
  ReasonSelected.add(newReason);
}
 void displaySnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("You should Select Icons"),
      duration: Duration(seconds: 2), // Adjust duration as needed
    ),
  
  );
}
void SaveAndNaviagtion(BuildContext context)
{
  if(SelectedMood==" ")
  {
      displaySnackBar(context);
  }
  else 
  {
       SaveSecondEmotions();
       GetActivitiesandReason();

  }
}
void saveansNavigateJournaling(BuildContext context)
{
  if(ActivitiesSelected.isEmpty || ReasonSelected.isEmpty )
  {
      displaySnackBar(context);
  }
  else 
  {
      SaveActivity();
      SaveReason();
      emit(JournalingState());
      
  }
}



Future<ReportModel?> GetDailyReport() async   
{
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
     Map<String, String> headers = 
     {
        'Authorization':'Bearer $accessToken',
     };
    final response = await http.get(
      Uri.parse("${constants.BaseURL}/api/report/"),
      headers: headers);
    if (response.statusCode == 200) 
    {
       dynamic responseData = jsonDecode(response.body);
       
       print(responseData);
       return  ReportModel.fromJson(responseData);
    
       
    } 
    else 
    { 
      print("error ${response.statusCode}");
      return null;
     
    }
  } catch (e) 
  { 
    print("error ${e}");
    return null;
   
  }
}
}
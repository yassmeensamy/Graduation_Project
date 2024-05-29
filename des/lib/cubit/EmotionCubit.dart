import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ActivityModel.dart';
import '../Models/PrimaryEmotionsModel.dart';
import '../Models/ReasonModel.dart';
import '../Models/SecondMoodModel.dart';
import 'EmotionCubitState.dart';

class SecondLayerCubit extends Cubit<SecondLayerCubitCubitState> {
  SecondLayerCubit() : super(EmotionCubitStateIntial ())
  {
         
  }
  List<SecondMoodModel> secondEmotions = [];
   List<PrimaryMoodModel> primaryEmotions=[];
  List<Map<String, String>> ActivitiesSelected=[];
  List<Map<String, String>> ReasonSelected=[];
    String SelectedMood=" ";
    String EmotionType=" " ;
    String ImagePath=" ";





 void displaySnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("You should answer the previous question"),
      duration: Duration(seconds: 2), // Adjust duration as needed
    ),
  
  );
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
    Response response=await http.post(Uri.parse("http://157.175.185.222/api/reason-entries/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==201)
     {
          dynamic responseData = jsonDecode(response.body);
          print("done2");
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
    Response response=await http.post(Uri.parse("http://157.175.185.222/api/activity-entries/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==201)
     {
          dynamic responseData = jsonDecode(response.body);
          print("done1");
     }
      else 
      {

          
          emit(EmotionCubitStateFailur("Request failed with status: ${response.statusCode}"));
      }

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
Future<void> GetPrimaryEmotions() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String ? accessToken = prefs.getString('accessToken');
    String ? accessToken ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2MjUwMjg1LCJpYXQiOjE3MTAyNTAyODUsImp0aSI6IjQ2YTg5NWE2ZjBmZDRlMGViNTRlNTk1MDIyMDJiNjg5IiwidXNlcl9pZCI6MX0.mTx7JXgwDzp1N7H9yd5xcKDa92WMK-T_S_PnwWX7vGI";
     Map<String, String> headers = {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    final response = await http.get(
      Uri.parse("http://157.175.185.222/api/primary-emotions/"),
      headers: headers,
    );
    if (response.statusCode == 200) 
    {
      List<dynamic> responseData = jsonDecode(response.body);
       primaryEmotions = (responseData).map((item) =>PrimaryMoodModel.fromJson(item)).toList();
     
    } 
    else 
    {
      print(response.statusCode);
     
    }
  } catch (e) 
  { 
    print("lol");
   
  }
}

Future<void> getSecondEmotions(String type,String imagePath) async
   {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    Map<String, String> headers = {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };

    try {
      var data = {'type': type};
      var jsonData = jsonEncode(data); 
      var response = await http.post(
        Uri.parse("http://157.175.185.222/api/emotions/"), // Use Uri.parse for the URL
        body: jsonData,
        headers: headers,
        );
      if (response.statusCode == 200) 
      {
         List<dynamic> responseData = jsonDecode(response.body);
         secondEmotions = responseData.map((item) => SecondMoodModel.fromJson(item, "http://157.175.185.222")).toList();
        if (secondEmotions.isNotEmpty) 
        { 
           EmotionType=type;
           ImagePath=imagePath;

          emit(EmotionCubitStateSucess( secondEmotions,imagePath,type ));
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
    Response response=await http.post(Uri.parse("http://157.175.185.222/api/journal-entry/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==200)
     {
         dynamic responseData = jsonDecode(response.body);
         emit(conclusionState());     
     }
      else 
      { 
          print(response.statusCode);
          emit(EmotionCubitStateFailur("Request failed with status: ${response.statusCode}"));
      }


}

Future<void> SaveSecondEmotions() async
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
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    Response response=await http.post(Uri.parse("http://157.175.185.222/api/mood-second-entry/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==200)
     {
          print ("done");
          dynamic responseData = jsonDecode(response.body);
          print(responseData);
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
    Uri.parse("http://157.175.185.222/api/activities/"),
    headers: headers,
  );
  if (response1.statusCode == 200) 
  {
    List<dynamic> responseData1 = jsonDecode(response1.body);
    activities = responseData1.map((item) => ActivityModel.fromjson(item)).toList();
    //print(activities);
  } 
  else 
  {
    emit(EmotionCubitStateFailur("Request failed with status: ${response1.statusCode}"));
    return;
  }

  Response response2 = await http.get(
    Uri.parse("http://157.175.185.222/api/reasons/"),
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
}
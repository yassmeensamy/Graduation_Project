import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Features/HomeScreen/HomeCubits/PlanTaskCubit/plan_tasks_cubit.dart';
import 'package:des/Features/Plans/Models/AcivityModel.dart';
import 'package:des/Features/Plans/Models/TopicModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; 
import '/constants.dart' as constants;
import 'dart:convert';

part 'depression_state.dart';

class DepressionCubit extends Cubit<DepressionState> 
{
  TopicModel? topic;
  bool UserDepressionFlag=false;
   List< ActivityplanModel >DepressionAcitivys =[];
   List<ActivityplanModel> CurrentDepressionAcitivy=[];
   bool checkDepression=false;
   bool Retaketest=false ;
   DepressionCubit() : super(Depressionloading())
   {
    CheckDepression();
    FetchActivityDepresion();
    
   }
  Future<void> CheckDepression() async 
  { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $accessToken',};
      var response = await http.get( Uri.parse("${constants.BaseURL}/api/consecutive-depression-check/"), headers: headers);
      if (response.statusCode == 200) 
      {
        dynamic data = jsonDecode(response.body);
        checkDepression= data["depression_streak"]; 
        if(checkDepression==false)
        {
          //مكانها هنا مش صح بس لازم نععمل كده هلشان تتعرض
          //topic=TopicModel(id: 10, name: "DepressionTest", colorTheme: "6495ED", image: "assets/images/depressionplan.png", Activities: [], enrolled: true);
        }
      } 
    } 
    catch (e) 
    {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }
 Future<void>FetchActivityDepresion() async
 {
    CurrentDepressionAcitivy = [];
    DepressionAcitivys = [];
    Depressionloading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    Map<String, String> headers = { 'Authorization': 'Bearer $accessToken'};
    try{
    var response = await http.get( Uri.parse("${constants.BaseURL}/api/dep_first-unflagged-activity/"), headers: headers);
    print(response.statusCode);
    if(response.statusCode==200)
    {
      
      UserDepressionFlag=true;
      print("enter in 200");
      topic = TopicModel(
            id: 10,
            name: "DepressionTest",
            colorTheme: "6495ED",
            image: "assets/images/depressionplan.png",
            Activities: [],
            enrolled: true);
            
     dynamic data=jsonDecode(response.body);
     ActivityplanModel  DepressionAcitivy=ActivityplanModel.fromJson(data);
     DepressionAcitivys.add(DepressionAcitivy);
      
     CheckActivityOrNO() ;
    }
    else if(response.statusCode==404)
    {
          print("enter in 404");
         dynamic data=jsonDecode(response.body);
           topic=null;
           if(data.containsKey("level_depression"))
           {
              Retaketest=true;
           }
           else 
           {
              Retaketest = false ;
            
           }

   
     
    }
    emit(Depressionloaded());
    }
    catch  (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
    
 }

   void CheckActivityOrNO() 
   {
    for (int i = 0; i < DepressionAcitivys.length; i++) 
    {
      if (DepressionAcitivys[i].message == " ") 
      {
        CurrentDepressionAcitivy.add(DepressionAcitivys[i]);
      }
    }
  }
  
  Future<bool> Mark_as_done(int activity_number) async 
  {
    var data = {"number": activity_number};
    var json_data = jsonEncode(data);
    Response response = await Api() .post(url: "${constants.BaseURL}/api/flag-depression-activity/", body: json_data);
    if (response.statusCode == 200) 
    {
      return true;
    } 
    else
     {
      return false;
    }
  }

  void RemoveFromToDoList(int ActivityId, BuildContext context) async
   {
    int index = 0;

    if (await Mark_as_done(ActivityId) == true) 
    {
      for (int i = 0; i < CurrentDepressionAcitivy.length - 1; i++) 
      {
        if (CurrentDepressionAcitivy[i].id == ActivityId) 
        {
          index = i;
        }
      }
      CurrentDepressionAcitivy.removeWhere((item) => item == CurrentDepressionAcitivy[index]);
      emit(Depressionloaded());
    
    }
      
    else 
    {
      emit(DepressionError());
    }
  }
  
}

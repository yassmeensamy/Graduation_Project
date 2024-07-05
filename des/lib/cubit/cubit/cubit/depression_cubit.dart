import 'package:bloc/bloc.dart';
import 'package:des/Models/Plans/AcivityModel.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; 
import '/constants.dart' as constants;
import 'dart:convert';

part 'depression_state.dart';

class DepressionCubit extends Cubit<DepressionState> 
{
   late ActivityplanModel DepressionAcitivy ;
   bool checkDepression=false;
   bool Retaketest=false ;
   DepressionCubit() : super(DepressionInitial());
  Future<void> CheckDepression() async 
  {
 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };

      var response = await http.get(
          Uri.parse("${constants.BaseURL}/api/consecutive-depression-check/"), headers: headers);
      if (response.statusCode == 200) 
      {
        dynamic data = jsonDecode(response.body);
        checkDepression= data["depression_streak"]; 
        print(checkDepression);
      } 
    
    } 
    catch (e) 
    {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }
 Future<void>FetchActivityDepresion() async
 {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    Map<String, String> headers = { 'Authorization': 'Bearer $accessToken'};
    try{
    var response = await http.get( Uri.parse("${constants.BaseURL}/api/dep_first-unflagged-activity/"), headers: headers);
    if(response.statusCode==200)
    {
      dynamic data=jsonDecode(response.body);
      DepressionAcitivy=ActivityplanModel.fromJson(data);
    }
    else if(response.statusCode==404)
    {
         dynamic data=jsonDecode(response.body);

           if(data.containsKey("level_depression"))
           {
              Retaketest=true;
           }
           else 
           {
              Retaketest = false ;
            //DepressionAcitivy==Null;
           }
       /*
       "detail": "No unflagged activity found for the user and depression level.",
    "level_depression": "moderate depression"
    */
    }
    }
    catch  (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
    
 }
}

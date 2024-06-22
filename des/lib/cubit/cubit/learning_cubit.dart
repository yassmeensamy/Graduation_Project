import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Models/Learning/LearningModel.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import '/constants.dart' as constants;
part 'learning_state.dart';

class LearningCubit extends Cubit<LearningState> 
{
   List<LearningModel> LearningTopics=[];

  LearningCubit() : super(LearningInitial())
  {
     //LoadLearningData();
     FetchMainTopics();

  }
  

   void LoadLearningData()
   {
    if(LearningTopics.isEmpty)
    {
      print("yalhaaaaaaaawy");
      FetchMainTopics();
    }
    else 
    {
      print ("we we we we");
    }
   }
   Future<void>FetchMainTopics() async {
    emit(LearingLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
    try {
      Map<String, String> headers = {
        'Authorization':
            'Bearer $accessToken',
                                    };
      var response = await http.get(
        Uri.parse(
          "${constants.BaseURL}/api/topics/",
        ),
        headers: headers,
        );

      if (response.statusCode == 200) 
      {

        List<dynamic> data= jsonDecode(response.body);
        LearningTopics= data.map((e) => LearningModel.fromJson(e)).toList();
         emit(LearningLoaded(LearningTopics));
       } 
      else 
       {
          print(response.statusCode);
          throw Exception('Failed to load lessons');
       }
    } catch (e) 
    {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<void> FetchSubTopic(int Topic_Id) async
  {
      var data={"topic_id":Topic_Id};
      var json_data=jsonEncode(data); 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
   Map<String, String> headers = 
   {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    Response response=await http.post(Uri.parse("${constants.BaseURL}/api/topics/subtopics/"),
     body: json_data, 
     headers: headers);
     
     if(response.statusCode==200)
     {
          dynamic responseData = jsonDecode(response.body);
          print(responseData.runtimeType);
     }
    else 
    {
         print(response.statusCode);
    }
  }
  
}

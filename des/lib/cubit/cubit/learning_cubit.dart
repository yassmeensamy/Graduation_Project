import 'dart:convert';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:des/Models/Learning/LearningModel.dart';
import 'package:des/Models/Learning/Lesson.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import '/constants.dart' as constants;
part 'learning_state.dart';

class LearningCubit extends Cubit<LearningState> 
{

   List<LearningModel> LearningTopics=[];
     List<String> subParagraphs=[];
      LearningCubit() : super(LearningInitial())
  {
     FetchMainTopics();

  }
   void GetTopicsandLessons(int Topic_Id) async
  {
  LearningModel? subtopics = await FetchSubTopic(Topic_Id);
  Map<int, List<Lessons>> SubTopicLessons = {};
  List<Lessons> lessons = [];
  await Future.forEach(subtopics!.subtopics!, (element) async 
  {
    lessons = await FetchSubLessons(element.id);
    SubTopicLessons[element.id] = lessons;
  });
  emit(LearningSubTopicsState(SubTopicLessons,subtopics));
}
 void resetContent()
 {
     emit(LearningLoaded(LearningTopics));
 }
    Future<List<Lessons>> FetchSubLessons(int subtopic_id) async
  {
     var data={"subtopic_id":subtopic_id};
    var json_data=jsonEncode(data); 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
   Map<String, String> headers = 
   {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' // You don't need this header for this request
    };
    Response response=await http.post(Uri.parse("${constants.BaseURL}/api/subtopics/lessons/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==200)
     {
          List<dynamic> responseData = jsonDecode(response.body);
         List<Lessons> SubTopicLessons=responseData.map((e) {return Lessons.fromJson(e);},).toList();
          return SubTopicLessons;
     }
    else 
    {
         print(response.statusCode);
         return [];
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

  Future<LearningModel?> FetchSubTopic(int Topic_Id) async
  {
    //emit(LearningSubTopicsLoadingState());
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
           LearningModel SubTopicTotal =LearningModel.fromJson(responseData);
           return SubTopicTotal;
          
     }
    else 
    {
         print(response.statusCode);
         return null;
    }
  }
  
 
 Future<List<String>> FetchContent(int lesson_id) async
  {
    emit(LearingLoading());
     var data={"lesson_id":lesson_id};
    var json_data=jsonEncode(data); 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
   Map<String, String> headers = 
   {
      'Authorization':
          'Bearer $accessToken'
      ,'Content-Type': 'application/json' 
    };
    Response response=await http.post(Uri.parse("${constants.BaseURL}/api/lessons/"),
     body: json_data, 
     headers: headers);
     if(response.statusCode==200)
     {
          dynamic responseData = jsonDecode(response.body);
           String LessonContent=responseData['content'];
            subParagraphs = LessonContent.split(". ");
          print(LessonContent);
          emit(LessonContentState(this. subParagraphs));
          return subParagraphs;
     }
    else 
    {
         print(response.statusCode);
         return [];
    }
  }
  
}

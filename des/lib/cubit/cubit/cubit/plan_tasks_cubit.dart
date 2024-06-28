import 'package:bloc/bloc.dart';
import 'package:des/Models/PlanTodoModel.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; 
import '/constants.dart' as constants;
import 'dart:convert';

part 'plan_tasks_state.dart';

class PlanTasksCubit extends Cubit<PlanTasksState> 
{
  late  PlanTodoModel planTasks;
  PlanTasksCubit() : super(PlanTasksloading());
  
Future<void>FetchPlanToDoList() async
{
  emit(PlanTasksloading());
 try
 {
 SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
     Map<String, String> headers =
      {
      'Authorization':
          'Bearer $accessToken'
      };
    final response = await http.get(
      Uri.parse("${constants.BaseURL}/api/first-false-user-activity/"),
      headers: headers,
    );
    if(response.statusCode==200)
    {
      dynamic responseData = jsonDecode(response.body);
      planTasks=PlanTodoModel.fromJson(responseData);
     emit(PlanTasksloaded());
    }
    else 
    {
      
      print(response.statusCode);
    }
 } catch(e)
 {
  print(e);
 }
}

Future<bool> Mark_as_done(int activity_number,String topic_name) async
{
     var data={"activity_number":activity_number,"topic_name":topic_name};
     var json_data=jsonEncode(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ?accessToken = prefs.getString('accessToken');
     Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json' ,
    };
    Response response= await http.post(Uri.parse("${constants.BaseURL}/api/flag-activity/"),headers: headers,body:json_data );
     if(response.statusCode==200)
     {
          
          return true ;
     }
     else 
     {
      return false ;
     }
  
  }



void RemoveFromToDoList(int ActivityId  ,String topic_name) async
{
  int index=0;
  if (await Mark_as_done(ActivityId,topic_name)==true)
  {
    
    print(planTasks.plansToDo.length);
    for (int i=0 ;i<planTasks.plansToDo.length;i++)
    {
      if(planTasks.plansToDo[i].name==topic_name)
      {
         index=i;
      }
    }

     planTasks.plansToDo.removeWhere((item) => item == planTasks.plansToDo[index]); 
          emit(PlanTasksloaded());
  }
  else 
  {
     emit(PlanTasksError());
  }
 

}
}

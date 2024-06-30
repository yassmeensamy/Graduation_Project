import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Models/PlanTodoModel.dart';
import 'package:des/Models/Plans/TopicModel.dart';
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
  List<TopicModel> plan=[];
  PlanTasksCubit() : super(PlanTasksloading());

 
Future<void>FetchPlanToDoList() async
{
 emit(PlanTasksloading());
 try
 {
    Response response = await Api().get(url: "${constants.BaseURL}/api/first-false-user-activity/");
    if(response.statusCode==200)
    {
      dynamic responseData = jsonDecode(response.body);
      planTasks=PlanTodoModel.fromJson(responseData);
      plan=planTasks.plansToDo;
           emit(PlanTasksloaded());
    }
 } 
 catch(e)
 {
  print(e);
 }
}

Future<bool> Mark_as_done(int activity_number,String topic_name) async
{
     var data={"activity_number":activity_number,"topic_name":topic_name};
     var json_data=jsonEncode(data);
     Response response = await Api().post(url:"${constants.BaseURL}/api/flag-activity/",body:json_data );
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

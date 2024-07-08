import 'package:des/Api/Api.dart';
import 'package:des/Features/HomeScreen/FinishTaskScreen.dart';
import 'package:des/Features/HomeScreen/HomeCubits/DepressionPlanCubit/depression_cubit.dart';
import 'package:des/Features/Plans/Models/AcivityModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '/constants.dart' as constants;
import 'dart:convert';
part 'plan_tasks_state.dart';


class PlanTasksCubit extends Cubit<PlanTasksState> {
  List<ActivityplanModel> plan = [];
  List<ActivityplanModel> CurrentActivityplan = [];
  PlanTasksCubit() : super(PlanTasksloading());
  Future<void> FetchPlanToDoList() async {
    emit(PlanTasksloading());
    try {
      Response response = await Api().get(url: "${constants.BaseURL}/api/first-false-user-activity/");
      if (response.statusCode == 200) 
      {
        print(" enter in get tasks plan");
        dynamic responseData = jsonDecode(response.body);
        List<dynamic>Todoplans = responseData["first_false_activities"];
        print(Todoplans.length);
        plan=Todoplans.map((e) => ActivityplanModel.fromJson(e)).toList();
        CheckActivityOrNO();
        print(plan.length);
        print(CurrentActivityplan.length);
        emit(PlanTasksloaded());
      }
    } 
    catch (e) 
    {
      print("error ${e}");
    }
  }

  void CheckActivityOrNO ()
  {
    CurrentActivityplan=[];
    for (int i=0 ;i<plan.length ;i++)
    { 
      if(plan[i].message ==" ")
      {
        CurrentActivityplan.add(plan[i]);
      }
    }
  }
  
  Future<bool> Mark_as_done(int activity_number, String topic_name) async {
    var data = {"activity_number": activity_number, "topic_name": topic_name};
    var json_data = jsonEncode(data);
    Response response = await Api()
        .post(url: "${constants.BaseURL}/api/flag-activity/", body: json_data);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void RemoveFromToDoList(int ActivityId, String topic_name ,BuildContext context) async {
    int index = 0;
    
    if (await Mark_as_done(ActivityId, topic_name) == true) 
    {
     
      for (int i = 0; i < CurrentActivityplan.length-1; i++) 
      {
        if (CurrentActivityplan[i].TopicName == topic_name) {
          index = i;
        }
      }
     CurrentActivityplan.removeWhere((item) => item == CurrentActivityplan[index]);
     if (context.read<PlanTasksCubit>().CurrentActivityplan.length + BlocProvider.of<DepressionCubit>(context).CurrentDepressionAcitivy.length==0) 
     {
        Navigator.push(context,MaterialPageRoute(  builder: (context) => TemporaryScreen(),),);
    }
      emit(PlanTasksloaded());
    } 
    else
     {
      emit(PlanTasksError());
     }
  }
  
  
}
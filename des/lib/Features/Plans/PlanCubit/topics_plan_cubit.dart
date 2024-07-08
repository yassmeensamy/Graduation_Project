import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Features/HomeScreen/HomeCubits/DepressionPlanCubit/depression_cubit.dart';
import 'package:des/Features/Plans/Models/TopicModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;
part 'topics_plan_state.dart';

class TopicsPlanCubit extends Cubit<TopicsPlanState> 
{
   List<TopicModel> enrolledPlans = [];
  List<TopicModel> UnenrolledPlans = [];
  List<TopicModel>PlansTopics=[];
  TopicsPlanCubit() : super(TopicsPlanLoadingState())
  {
       FetchMainTopics();
  }

   Future<void>FetchMainTopics() async 
   { 
     emit(TopicsPlanLoadingState());
     try
     {
      enrolledPlans = [];
      UnenrolledPlans = [];
     Response response = await Api().get(url:"${constants.BaseURL}/api/plan/topics/");
      if (response.statusCode == 200) 
      {
        List<dynamic> data= jsonDecode(response.body);
        PlansTopics= data.map((e) => TopicModel.fromJson(e)).toList();
     
        for(int i=0 ;i<PlansTopics.length;i++)
        {
         
          if(PlansTopics[i].enrolled==true)
          {
                enrolledPlans.add(PlansTopics[i]);
          }
          else 
          {
                UnenrolledPlans.add(PlansTopics[i]);
          }
        }
          
        emit(TopicsPlanLoadedState(PlansTopics));
       } 
      else 
       {
          emit(TopicsPlanErrorState('Failed to load lessons'));
          throw Exception('Failed to load lessons');     
       } 
   }
    catch (e) 
    {
      emit(TopicsPlanErrorState('Failed to load lessons'));
      throw Exception('Failed to fetch data: ${e.toString()}');
      
  }
}
}
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Models/Plans/TopicModel.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '/constants.dart' as constants;
part 'topics_plan_state.dart';

class TopicsPlanCubit extends Cubit<TopicsPlanState> 
{
  TopicsPlanCubit() : super(TopicsPlanLoadingState())
  {
       FetchMainTopics();
  }

   Future<void>FetchMainTopics() async 
   { 
     emit(TopicsPlanLoadingState());
     try
     {
     Response response = await Api().get(url:"${constants.BaseURL}/api/plan/topics/");
      if (response.statusCode == 200) 
      {
        List<dynamic> data= jsonDecode(response.body);
        List<TopicModel>PlansTopics= data.map((e) => TopicModel.fromJson(e)).toList();
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
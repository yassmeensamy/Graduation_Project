import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Models/Plans/AcivityModel.dart';
import 'package:des/Models/Plans/TopicModel.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;
part 'plan_tips_state.dart';

class PlanTipsCubit extends Cubit<PlanTipsState> {
  late TopicModel PlansTopicTips;
  PlanTipsCubit() : super(PlanTipsLoading());


  Future<void> FetchPlanActivities(String topic_name) async {
    emit(PlanTipsLoading());
    var data = {"topic_name": topic_name};
    var json_data = jsonEncode(data);
    try 
    {
      Response response = await Api().post( url: "${constants.BaseURL}/api/plan/topic-activities/", body: json_data);
      if (response.statusCode == 200) 
      {
        dynamic data = jsonDecode(response.body);
        PlansTopicTips = TopicModel.fromJson(data);
      
        for (int i = 0; i < PlansTopicTips.Activities.length; i++) 
        {
          if (PlansTopicTips.Activities[i].flag == true) 
          {
            await FetchActivitiesContent(PlansTopicTips.name, i);
          }
        }
        emit(PlanTipsLoaded(PlansTopicTips));
      } 
      else {
        print("error  ${response.statusCode}");
        emit(PlanTipsError('Failed to load lessons'));
        throw Exception('Failed to load lessons');
      }
    } catch (e) 
    {
      //print("expextion:${e}");
      //emit(PlanTipsError('Failed to load lessons'));
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<void> RestartPlan(String topic_name) async {
    emit(PlanTipsLoading());
    var data = {"topic_name": topic_name};
    var json_data = jsonEncode(data);
    try {
      Response response = await Api().post(
          url: "${constants.BaseURL}/api/plan/restart-topic/", body: json_data);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        TopicModel PlansTopicTips = TopicModel.fromJson(data);
        /*
         for(int i=0 ;i< PlansTopicTips.Activities.length; i++)
         {
            await   FetchActivitiesContent(PlansTopicTips.name,i+1);
         }
         */
        emit(PlanTipsLoaded(PlansTopicTips));
      } else {
        emit(PlanTipsError('Failed to load lessons'));
        throw Exception('Failed to load lessons');
      }
    } catch (e) {
      emit(PlanTipsError('Failed to load lessons'));
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<void> FetchActivitiesContent(String topic_name, int num_Act) async {
    var data = {
      "topic_name": topic_name,
      "number": PlansTopicTips.Activities[num_Act].id!
    };
    var json_data = jsonEncode(data);
    try {
      Response response = await Api().post(
          url: "${constants.BaseURL}/api/plan/activity-text/", body: json_data);
      if (response.statusCode == 200) 
      {
        dynamic data = jsonDecode(response.body);
        ActivityplanModel activity = ActivityplanModel.fromJson(data);
        PlansTopicTips.Activities[num_Act].content = activity.content!;
        print("error:${activity.content!}");
      } 
      else {
        emit(PlanTipsError('Failed to load lessons'));
        throw Exception('Failed to load lessons');
      }
    } catch (e) {
      print("offffff error");
      emit(PlanTipsError('Failed to load lessons'));
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }
}

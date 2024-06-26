import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Models/Plans/TopicModel.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '/constants.dart' as constants;
part 'topics_plan_state.dart';

class TopicsPlanCubit extends Cubit<TopicsPlanState> 
{
  TopicsPlanCubit() : super(TopicsPlanLoadingState())
  {
    FetchMainTopics();
  }

   Future<void>FetchMainTopics() async {
    
    emit(TopicsPlanLoadingState());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
     try {
      Map<String, String> headers = {
        'Authorization':
            'Bearer $accessToken',
                                    };
      var response = await http.get(
        Uri.parse(
          "${constants.BaseURL}/api/plan/topics/",
        ),
        headers: headers,
        );

      if (response.statusCode == 200) 
      {

        List<dynamic> data= jsonDecode(response.body);
        List<TopicModel>PlansTopics= data.map((e) => TopicModel.fromJson(e)).toList();
        print(PlansTopics);
        emit(TopicsPlanLoadedState(PlansTopics));
       } 
      else 
       {
          print(response.statusCode);
          emit(TopicsPlanErrorState('Failed to load lessons'));
          throw Exception('Failed to load lessons');
         
       }
    } catch (e) 
    {
      emit(TopicsPlanErrorState('Failed to load lessons'));
      throw Exception('Failed to fetch data: ${e.toString()}');
      
  }
}
}
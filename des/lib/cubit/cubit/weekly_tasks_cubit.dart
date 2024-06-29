import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Models/WeeklyToDoModel.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '/constants.dart' as constants;
part 'weekly_tasks_state.dart';

class WeeklyTasksCubit extends Cubit<WeeklyTasksState> 
{
  WeeklyTasksCubit() : super(WeeklyTasksLoading());

  List<WeeklyToDoPlan>WeeklyToDo=[];
  
Future<void> GetWeeklyToDo() async
{
    emit(WeeklyTasksLoading());
    Response response =await Api().get(url: "${constants.BaseURL}/api/unchecked-activities/");
    if(response.statusCode==200)
    {
       List<dynamic> responseData = jsonDecode(response.body);
       WeeklyToDo = (responseData).map((item) =>WeeklyToDoPlan.fromJson(item)).toList();
       emit(WeeklyTaskLoaded());
    }
    else 
    {
      print(response.statusCode); 
      emit( WeeklyTaskError());
    }
}
Future <bool>CheckActivity(int ActivityId) async
{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String ?accessToken = prefs.getString('accessToken');
     Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken'
    };
    String baseUrl="${constants.BaseURL}/api/check-activity/";
    String Url=baseUrl+ActivityId.toString()+"/";
    http.Response response= await http.patch(Uri.parse(Url),headers: headers );
    if(response.statusCode==200)
    {
      
       return true;
    }
    else 
    {
          
    return false ;
    }


}
void RemoveFromToDoList(int ActivityId ) async
{
  if (await CheckActivity(ActivityId)==true)
  {
    WeeklyToDo.removeWhere((item) => item.id == ActivityId); 
    emit(WeeklyTaskLoaded());
  }
  else 
  {
     emit( WeeklyTaskError());

  }
 

}
}

class CheckboxCubit extends Cubit<bool> {
  CheckboxCubit() : super(false);

  void toggleCheckbox(bool newValue) => emit(newValue);
}

import 'package:des/Models/Plans/TopicModel.dart';

class PlanTodoModel {
  List<TopicModel> plansToDo;
  PlanTodoModel({required this.plansToDo});

  factory PlanTodoModel.fromJson(Map<String, dynamic> json) 
  {
    dynamic todosJson = json["first_false_activities"] ;
    List<TopicModel> todos =todosJson.map((e)
    {
      //print(e);
      return TopicModel.fromJson(e); 
    }
      ).toList();
      print(todos.length);
    return PlanTodoModel(plansToDo: todos);
  }
}

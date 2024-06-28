import 'package:des/Models/Plans/TopicModel.dart';

class PlanTodoModel {
  List<TopicModel> plansToDo;
  PlanTodoModel({required this.plansToDo});

  factory PlanTodoModel.fromJson(Map<String, dynamic> json) 
  {
    List<dynamic> todosJson = json["first_false_activities"] ;
    List<TopicModel> todos =todosJson.map((e)
    {
      return TopicModel.fromJson(e); 
    }
    ).toList();
    return PlanTodoModel(plansToDo: todos);
  }
}

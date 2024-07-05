
import 'package:des/Features/Plans/Models/AcivityModel.dart';
class PlanTodoModel 
{
  List<ActivityplanModel> plansToDo;
  PlanTodoModel({required this.plansToDo});

  factory PlanTodoModel.fromJson(Map<String, dynamic> json) 
  {
    List<dynamic> todosJson = json["first_false_activities"] ;
    List<ActivityplanModel> todos =todosJson.map((e)
    {
      return ActivityplanModel.fromJson(e); 
    }
    ).toList();
    return PlanTodoModel(plansToDo: todos);
  }
}

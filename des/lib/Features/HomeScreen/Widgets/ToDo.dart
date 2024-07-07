
import 'package:des/Features/HomeScreen/HomeCubits/DepressionPlanCubit/depression_cubit.dart';
import 'package:des/Features/HomeScreen/HomeCubits/PlanTaskCubit/plan_tasks_cubit.dart';
import 'package:des/Features/HomeScreen/HomeCubits/WeeklyTasks/weekly_tasks_cubit.dart';
import 'package:des/Features/Plans/Models/AcivityModel.dart';
import 'package:des/Features/Weekly/Models/WeeklyToDoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TODo extends StatelessWidget {
  final dynamic todo;

  TODo({required this.todo});

  @override
  Widget build(BuildContext context) {
    context.read<CheckboxCubit>().toggleCheckbox(false);
    return ListTile(
      title: Text(
        todo is WeeklyToDoPlan
            ? todo.activityName
            : todo.content.substring(0, todo.content.indexOf(':')).trim(),
        style: TextStyle(fontSize: 20),
      ),
      subtitle: todo is WeeklyToDoPlan
          ? Text(todo.activityDescription)
          : Text(todo.content.substring(todo.content.indexOf(':') + 1).trim() +
              "(${todo.TopicName.isEmpty ? "depression Plan" : todo.TopicName})"),

      trailing: BlocBuilder<CheckboxCubit, bool>(
        builder: (context, isChecked) {
          return Checkbox(
            value: isChecked,
            onChanged: (newValue) {
              context.read<CheckboxCubit>().toggleCheckbox(newValue!);


             
              
              if (todo is ActivityplanModel) 
              {
                   if (todo.TopicName == " ")
                    {
                  BlocProvider.of<DepressionCubit>(context)
                      .RemoveFromToDoList(todo.id, context);
                }
                else 
                {
                BlocProvider.of<PlanTasksCubit>(context).RemoveFromToDoList(todo.id, todo.TopicName,context);
                }
              } 
             
              
              else 
              {
                
                BlocProvider.of<WeeklyTasksCubit>(context).RemoveFromToDoList(todo.id);
              }
            
              // Check if this is the last task
              
              
            },
          );
        },
      ),
    );
  }
}

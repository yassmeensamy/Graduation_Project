import 'package:des/Models/Plans/TopicModel.dart';
import 'package:des/Models/WeeklyToDoModel.dart';
import 'package:des/cubit/cubit/cubit/plan_tasks_cubit.dart';

import 'package:des/cubit/cubit/weekly_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TODo extends StatelessWidget 
{
   dynamic todo;
  TODo({required this.todo});

  @override
  Widget build(BuildContext context) 
  {
    context.read<CheckboxCubit>().toggleCheckbox(false);
    return 
    ListTile(
      title: Text(
              todo is  WeeklyToDoPlan? todo.activityName : todo.Activities[0].content.substring(0, todo.Activities[0].content.indexOf(':')).trim(),
               style: TextStyle(fontSize: 20),
        ),
      subtitle: todo is  WeeklyToDoPlan? Text(todo.activityDescription): Text(todo.Activities[0].content.substring( todo.Activities[0].content.indexOf(':')+1).trim()+"(${todo.name})"),
      trailing: BlocBuilder<CheckboxCubit, bool>(
        builder: (context, isChecked) {
          return Checkbox(
            value: isChecked,
            onChanged: (newValue) 
            {
              
              context.read<CheckboxCubit>().toggleCheckbox(newValue!);
              //context.read<CheckboxCubit>().toggleCheckbox(!newValue);
              if(todo is TopicModel)
              {
               
               // BlocProvider.of<PlanTasksCubit >(context).RemoveFromToDoList(todo.Activities[0].id, todo.name);
              }
              else
              {
              BlocProvider.of<WeeklyTasksCubit>(context).RemoveFromToDoList(todo.id);
              }
              
            },
          );
        },
      ),
    );
  }
}

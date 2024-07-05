import 'package:des/Models/Plans/AcivityModel.dart';
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
     return  ListTile(
      
      title: 
      
      Text( todo is  WeeklyToDoPlan? todo.activityName :   todo.content.substring(0,  todo.content.indexOf(':')) .trim(),  
               style: TextStyle(fontSize: 20), ),
               
              subtitle: todo is  WeeklyToDoPlan? Text(todo.activityDescription) : Text(todo.content.substring(todo.content.indexOf(':')+1).trim()+"${todo.TopicName}"),
               trailing: BlocBuilder<CheckboxCubit, bool>(
        builder: (context, isChecked) {
          return Checkbox(
            value: isChecked,
            onChanged: (newValue) 
            {
              
              context.read<CheckboxCubit>().toggleCheckbox(newValue!);
              //context.read<CheckboxCubit>().toggleCheckbox(!newValue);
              if(todo is ActivityplanModel)
              {
    
               BlocProvider.of<PlanTasksCubit >(context).RemoveFromToDoList(todo.id, todo.TopicName);
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

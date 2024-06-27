import 'package:des/Models/WeeklyToDoModel.dart';

import 'package:des/cubit/cubit/weekly_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TODo extends StatelessWidget {
  final WeeklyToDoPlan todo;
  TODo({required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.activityName,
        style: TextStyle(fontSize: 20),
      ),
      subtitle: Text(todo.activityDescription),
      trailing: BlocBuilder<CheckboxCubit, bool>(
        builder: (context, isChecked) {
          return Checkbox(
            value: isChecked,
            onChanged: (newValue) {
              print(newValue);
              context.read<CheckboxCubit>().toggleCheckbox(newValue!);
              BlocProvider.of<WeeklyTasksCubit>(context).RemoveFromToDoList(todo.id);
              context.read<CheckboxCubit>().toggleCheckbox(!newValue);
            },
          );
        },
      ),
    );
  }
}
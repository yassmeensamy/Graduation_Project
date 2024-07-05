part of 'weekly_tasks_cubit.dart';

@immutable
sealed class WeeklyTasksState {}

final class WeeklyTasksInitial extends WeeklyTasksState {}
final class WeeklyTasksLoading extends WeeklyTasksState {}
final class WeeklyTaskLoaded extends WeeklyTasksState {  }
final class WeeklyTaskError extends WeeklyTasksState {  }
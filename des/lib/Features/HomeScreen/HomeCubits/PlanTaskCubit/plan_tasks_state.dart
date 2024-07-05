part of 'plan_tasks_cubit.dart';

@immutable
sealed class PlanTasksState {}

final class PlanTasksInitial extends PlanTasksState {}
final class PlanTasksloading extends PlanTasksState {}

final class PlanTasksloaded extends PlanTasksState {}
final class PlanTasksError extends PlanTasksState{}
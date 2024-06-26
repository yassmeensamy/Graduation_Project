part of 'plan_tips_cubit.dart';

@immutable
sealed class PlanTipsState {}

final class PlanTipsInitial extends PlanTipsState {}
final class PlanTipsLoading extends PlanTipsState {}
final class PlanTipsLoaded extends PlanTipsState {
  TopicModel PlansTopicTips;
  PlanTipsLoaded(this.PlansTopicTips);
}
final class PlanTipsError extends PlanTipsState 
{
  String errormessge;
  PlanTipsError(this.errormessge);

}
final class PlanRestart extends PlanTipsState 
{
  List<ActivityplanModel> Activities;
  PlanRestart(this.Activities);
}

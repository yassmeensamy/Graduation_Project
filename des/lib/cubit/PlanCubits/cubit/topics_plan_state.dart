part of 'topics_plan_cubit.dart';

@immutable
sealed class TopicsPlanState {}

final class TopicsPlanInitial extends TopicsPlanState {}
final class TopicsPlanLoadingState extends TopicsPlanState {}
final class TopicsPlanLoadedState extends TopicsPlanState 
{
  List<TopicModel>topicsList;
  TopicsPlanLoadedState(this.topicsList);
}

final class TopicsPlanErrorState extends TopicsPlanState 
{
  String messege;
  TopicsPlanErrorState(this.messege);

}


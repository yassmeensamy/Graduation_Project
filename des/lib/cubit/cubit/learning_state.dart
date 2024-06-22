part of 'learning_cubit.dart';

@immutable
sealed class LearningState {}

final class LearningInitial extends LearningState {}

class LearingLoading extends LearningState {}
class LearningLoaded extends LearningState
{
 List<LearningModel>MainTopics=[];
  LearningLoaded(this.MainTopics);
}

class InsightError extends LearningState
{
  final String message;
  InsightError(this.message);

}
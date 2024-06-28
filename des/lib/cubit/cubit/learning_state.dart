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

class LearningError extends LearningState
{
  final String message;
  LearningError(this.message);

}
class LearningSubTopicsLoadingState extends LearningState 
{}
class SupTopicsLoading extends LearningState 
{}


class LearningSubTopicsState extends LearningState 
{
   Map<int,List<Lessons>>Total={};
   LearningModel? subtopics;
   LearningSubTopicsState(this.Total,this.subtopics);
   
}
/*
class LessonContentState extends LearningState
{
 List<String> subParagraphs=[];
 LessonContentState(this.subParagraphs);

}
*/
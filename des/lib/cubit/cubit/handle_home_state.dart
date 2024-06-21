part of 'handle_home_cubit.dart';

@immutable
sealed class HandleHomeState {}

final class HandleHomeInitial extends HandleHomeState {}
final class  HomeLoading extends  HandleHomeState {}
final class HomeLoaded extends  HandleHomeState 
{
  List<MoodModel> ? primaryEmotions=[];
  List<WeeklyToDoPlan> ? WeeklyToDo=[];
  bool? isEntry;
  ReportModel? report;
  HomeLoaded( {this.WeeklyToDo ,this.isEntry ,this.report ,this.primaryEmotions});
}



final class ToDoDoneClass extends HandleHomeState
{
  List<WeeklyToDoPlan> WeeklTasks=[];
  ToDoDoneClass( this. WeeklTasks);
}
final class  HomeError extends  HandleHomeState {
  String errormessge;
  HomeError(this.errormessge);
}

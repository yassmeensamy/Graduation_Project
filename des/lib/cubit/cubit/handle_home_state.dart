part of 'handle_home_cubit.dart';

@immutable
sealed class HandleHomeState {}
final class HandleHomeInitial extends HandleHomeState {}
final class  HomeLoading extends  HandleHomeState {}
final class HomeLoaded extends  HandleHomeState 
{
  List<PrimaryMoodModel> primaryEmotions=[];
  HomeLoaded(this.primaryEmotions);
}
final class  HomeError extends  HandleHomeState {
  String errormessge;
  HomeError(this.errormessge);
}

part of 'insigths_cubit.dart';


sealed class InsigthsState {}

final class InsigthsInitial extends InsigthsState {}

class InsightLoading extends InsigthsState {}

class InsightLoaded extends InsigthsState
{
  List<TestResultModel> depressionhistory;
  WeeklyHistoryModel weeklyHistory;
  List<ActivityModel>ActivitiesYear;
  List<ActivityModel>ActivitiesMonth;
  List<MoodModel>MoodHistory;
  //final DataModel data2;
  //final DataModel data3;

  InsightLoaded(this.depressionhistory ,this.weeklyHistory ,this.ActivitiesMonth,this.ActivitiesYear ,this.MoodHistory);
}

class InsightError extends InsigthsState 
{
  final String message;
  InsightError(this.message);
}

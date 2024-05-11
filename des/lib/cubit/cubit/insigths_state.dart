part of 'insigths_cubit.dart';


sealed class InsigthsState {}

final class InsigthsInitial extends InsigthsState {}

class InsightLoading extends InsigthsState {}

class InsightLoaded extends InsigthsState
{
  List<TestResultModel> data1;
  //final DataModel data2;
  //final DataModel data3;

  InsightLoaded(this.data1,);
}

class InsightError extends InsigthsState 
{
  final String message;
  InsightError(this.message);
}

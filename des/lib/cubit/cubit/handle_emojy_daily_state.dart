part of 'handle_emojy_daily_cubit.dart';

@immutable
sealed class HandleEmojyDailyState {}

final class HandleEmojyDailyInitial extends HandleEmojyDailyState {}
final class HandleEmojyDailyloading extends HandleEmojyDailyState {}
final class HandleEmojyloaded extends HandleEmojyDailyState {
  List<MoodModel>emotions;
  HandleEmojyloaded(this.emotions);
}

final class HandleReportloaded extends HandleEmojyDailyState {
  final ReportModel report;
  HandleReportloaded(this.report);
}
final class HandleEmojyDailyError extends HandleEmojyDailyState {}




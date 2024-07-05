part of 'lesson_content_cubit.dart';

@immutable
sealed class LessonContentState {}

final class LessonContentloaded extends LessonContentState {}

final class LessonContentloading extends LessonContentState {}

final class LessonContenterror extends LessonContentState {}

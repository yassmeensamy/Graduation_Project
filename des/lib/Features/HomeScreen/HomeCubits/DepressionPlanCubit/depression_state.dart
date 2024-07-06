part of 'depression_cubit.dart';

@immutable
sealed class DepressionState {}

final class DepressionInitial extends DepressionState {}
final class Depressionloading extends DepressionState {}
final class Depressionloaded extends DepressionState {}
final class DepressionError extends DepressionState {}

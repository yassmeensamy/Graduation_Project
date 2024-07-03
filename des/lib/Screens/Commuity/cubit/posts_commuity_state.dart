part of 'posts_commuity_cubit.dart';

@immutable
sealed class PostsCommuityState {}

final class PostsCommuityerror extends PostsCommuityState {}
final class PostsCommuityloading extends PostsCommuityState {}

final class PostsCommuitysuccess extends PostsCommuityState {}

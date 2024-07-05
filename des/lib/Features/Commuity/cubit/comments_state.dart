part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsLoading extends CommentsState {}
final class Commentserror extends CommentsState {}

final class CommentsSucess extends CommentsState 
{
  List<PostModel>comments=[];
  CommentsSucess(this.comments);
}

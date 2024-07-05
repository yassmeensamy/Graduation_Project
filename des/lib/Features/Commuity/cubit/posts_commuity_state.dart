
import 'package:des/Features/Commuity/Models/Post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


@immutable
sealed class PostsCommunityState {}

// Enum for request state
enum RequestState { loading, loaded, error }

// Extending the Equatable class to support value comparisons
class PostsState extends Equatable {
  final List<PostModel>? posts;
  final RequestState postsState;

  PostsState({
    this.posts ,
    this.postsState = RequestState.loading,
  });
  
  PostsState copyWith({
    List<PostModel>? posts,
    RequestState? postsState,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      postsState: postsState ?? this.postsState,
    );
  }

  @override
  List<Object?> get props => [posts, postsState];
}

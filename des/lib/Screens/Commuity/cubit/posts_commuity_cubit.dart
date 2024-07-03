import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Screens/Commuity/Models/Post.dart';
import 'package:des/Screens/Commuity/cubit/posts_commuity_state.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;

/*
class PostsCommuityCubit extends Cubit<PostsCommuityState> 
{
  List<PostModel>AllPosts=[];
  PostsCommuityCubit() : super(PostsCommuityloading());
  Future<void>GetAllpost() async
  {
   
    Response response = await Api().get(url: "${constants.BaseURL}/api/posts/",);
    List<dynamic> responsedata = jsonDecode(response.body);
    AllPosts=responsedata.map((e) => PostModel.fromJson(e)).toList();
    emit(PostsCommuitysuccess());
  }
  Future<void> LikePost(int post_id) async
  {
    var data={"post_id":post_id};
    var json_data=jsonEncode(data);
    Response response = await Api().post
    (
      url: "${constants.BaseURL}/api/posts/", body: json_data
    );

  }
  //void Reset()
}
*/
class PostsCommunityCubit extends Cubit<PostsState> 
{
  PostsCommunityCubit() : super( PostsState());
     List<PostModel> allPosts=[];
  Future<void> getAllPosts() async {
    try {
      //emit(state.copyWith(postsState: RequestState.loading));
      Response response = await Api().get(url: "${constants.BaseURL}/api/posts/");
      List<dynamic> responseData = jsonDecode(response.body);
     allPosts = responseData.map((e) => PostModel.fromJson(e)).toList();
      emit(state.copyWith(posts: allPosts, postsState: RequestState.loaded));
    } catch (e) {
      emit(state.copyWith(postsState: RequestState.error));
    }
  }


  

  /*
  Future<void> likePost(int postId) async {
    try {
      var data = {"post_id": postId};
      var jsonData = jsonEncode(data);
      await Api().post(
        url: "${constants.BaseURL}/api/posts/like",
        body: jsonData,
      );
      // Optionally, update state after liking a post
    } catch (e) {
      emit(state.copyWith(postsState: RequestState.error));
    }
  }
  */
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Screens/Commuity/Models/Post.dart';
import 'package:des/Screens/Commuity/cubit/posts_commuity_state.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;



class PostsCommunityCubit extends Cubit<PostsState> 
{

  PostsCommunityCubit() : super( PostsState());
     List<PostModel> allPosts=[];

      String Extracttime(String time)
     {
      DateTime now = DateTime.now();
      DateTime datetime = DateTime.parse(time);
      Duration difference = now.difference(datetime);
        difference.inHours;
      if(difference.inHours==0)
      {
        return difference.inMinutes.remainder(60).toString()+" Mins";
      }
      else
      {
           int daysAgo = difference.inDays;
           if(daysAgo==0)
         return difference.inHours.toString()+" hours";
         else 
         return daysAgo.toString()+" day";
      }
     }
  Future<void> getAllPosts() async {
    try {
      //emit(state.copyWith(postsState: RequestState.loading));
      Response response = await Api().get(url: "${constants.BaseURL}/api/posts/");
    
      List<dynamic> responseData = jsonDecode(response.body);
    
     allPosts = responseData.map((e) => PostModel.fromJson(e)).toList().reversed.toList();
      for(int i=0 ;i<allPosts.length ;i++)
      {
        allPosts[i].postDate =Extracttime(allPosts[i].postDate).toString();
      }
      emit(state.copyWith(posts: allPosts, postsState: RequestState.loaded));
    } 
    catch (e) 
    {
      emit(state.copyWith(postsState: RequestState.error));
    }
  }
 Future<void>DeletePost(int Post_id) async
 {

    var data={"id": Post_id};
    var json_data=jsonEncode(data);
    Response response = await Api().delete(url:"${constants.BaseURL}/api/posts/delete/", body:json_data );
    print(response.statusCode);
    
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

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Screens/Commuity/Models/Post.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;
part 'posts_commuity_state.dart';

class PostsCommuityCubit extends Cubit<PostsCommuityState> 
{
  List<PostModel>AllPosts=[];
  PostsCommuityCubit() : super(PostsCommuityloading());
  Future<void>GetAllpost() async
  {
    emit(PostsCommuityloading());
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

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Screens/Commuity/Models/CommentModel.dart';
import 'package:des/Screens/Commuity/Models/Post.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;
part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> 
{
  List<PostModel> comments=[];
  CommentsCubit() : super(CommentsLoading());
  Future<void>GetAllcomments(int id) async
  {
    emit(CommentsLoading());
    var data = {"post_id": id};
    var json_data = jsonEncode(data);
    Response response = await Api().post(url: "${constants.BaseURL}/api/comments/",body: json_data, );
    List<dynamic>responsedata=jsonDecode(response.body);
    comments=responsedata.map((e) =>PostModel.fromJson(e)).toList();
    emit(CommentsSucess(comments));
  }
  Future<void>CreateComment (int id , String Content) async
  {
     print("create is done");
   var data={ "post_id": id,"content": Content};
   var json_data=jsonEncode(data);
   Response response = await Api().post( url: "${constants.BaseURL}/api/comments/create/", body: json_data, );
     dynamic responsedata= jsonDecode(response.body);
     dynamic commentdata=responsedata["comment"];
     PostModel comment= PostModel.fromJson(commentdata);
     comments.add(comment);
     emit(CommentsSucess(comments));

  }
}

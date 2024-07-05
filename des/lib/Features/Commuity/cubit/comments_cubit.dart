import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Features/Commuity/Models/Post.dart';
import 'package:des/Models/user.dart';
import 'package:des/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
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
  bool IsCreator(BuildContext context , User user )
  {
     UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
     User? currentUser = userProvider.user;
     if(currentUser!.email==user.email)
     {
      return true;
     }
     else
     {
      return false;
     }
  }
}
/*

class TooltipSample extends StatelessWidget {
  final String description;
  final Widget child;
  const TooltipSample({required this.description ,required this.child});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      child: Material(
       
       
        child:  child,
        ),
      
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(description),
      ),
    );
  }
}
*/

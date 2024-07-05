import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Features/Commuity/Models/Post.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;
part 'commuity_cubit_state.dart';

class CommuityCubitCubit extends Cubit<CommuityCubitState>
 {
  CommuityCubitCubit() : super(createPostloading());

  Future<dynamic> CreateNewPost (String Newpost,File image) async 
  {
    print(image.path);
    var data = {"content": Newpost};
    var json_data = jsonEncode(data);
    Response response = await Api().post(url: "${constants.BaseURL}/api/lessons/",body: json_data, );
  
    dynamic responsedate=jsonDecode(response.body);
    PostModel post=PostModel.fromJson(responsedate);
    //emit()
  }

  Future<void>UpdatePost(String UpdatePost) async
  {
    var data = {"content": UpdatePost};
    var json_data = jsonEncode(data);
    Response response = await Api().post(url: "${constants.BaseURL}/api/posts/update/",body: json_data, );
  }
}

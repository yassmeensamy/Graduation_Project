import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;
part 'commuity_cubit_state.dart';

class CommuityCubitCubit extends Cubit<CommuityCubitState>
 {
  CommuityCubitCubit() : super(createPostloading());

  Future<dynamic> CreateNewPost ()
  async {
    //var data = {"content": "lil"};
    //var json_data = jsonEncode(data);
     //Response response = await Api().post(url: "${constants.BaseURL}/api/lessons/",body: json_data, );
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import '/constants.dart' as constants;
part 'lesson_content_state.dart';

class LessonContentCubit extends Cubit<LessonContentState> 
{
  LessonContentCubit() : super(LessonContentloading());
   List<String> subParagraphs = [];
  Future<List<String>> FetchContent(int lesson_id) async {
    emit(LessonContentloading());
    var data = {"lesson_id": lesson_id};
    var json_data = jsonEncode(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    Response response = await http.post(
        Uri.parse("${constants.BaseURL}/api/lessons/"),
        body: json_data,
        headers: headers);
    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);
      String LessonContent = responseData['content'];
      subParagraphs = LessonContent.split(". ");
      print(LessonContent);
      emit(LessonContentloaded());
      return subParagraphs;
    } else {
      print(response.statusCode);
      return [];
    }
  }
}

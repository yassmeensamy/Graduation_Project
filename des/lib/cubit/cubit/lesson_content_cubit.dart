import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
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
    Response response = await Api().post(url: "${constants.BaseURL}/api/unchecked-activities/",body: json_data, );
    if (response.statusCode == 200) 
    {
      dynamic responseData = jsonDecode(response.body);
      String LessonContent = responseData['content'];
      subParagraphs = LessonContent.split(". ");
      emit(LessonContentloaded());
      return subParagraphs;
    } 
    else 
    {
      return [];
    }
  }
}

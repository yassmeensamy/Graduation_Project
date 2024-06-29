import 'dart:convert';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:des/Models/Learning/LearningModel.dart';
import 'package:des/Models/Learning/Lesson.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // Use http from package:http/http.dart
import '../../Api/Api.dart';
import '/constants.dart' as constants;
part 'learning_state.dart';

class LearningCubit extends Cubit<LearningState> {
  List<LearningModel> LearningTopics = [];
  List<String> subParagraphs = [];
  LearningCubit() : super(LearningInitial())
   {
    FetchMainTopics();
  }
  Future<void> GetTopicsandLessons(int Topic_Id) async {
    //emit(SupTopicsLoading());
    LearningModel? subtopics = await FetchSubTopic(Topic_Id);
    Map<int, List<Lessons>> SubTopicLessons = {};
    List<Lessons> lessons = [];
    await Future.forEach(subtopics!.subtopics!, (element) async {
      lessons = await FetchSubLessons(element.id);
      SubTopicLessons[element.id] = lessons;
    });
    emit(LearningSubTopicsState(SubTopicLessons, subtopics));
  }

  void resetContent() {
    emit(LearningLoaded(LearningTopics));
  }

  Future<List<Lessons>> FetchSubLessons(int subtopic_id) async {
    var data = {"subtopic_id": subtopic_id};
    var json_data = jsonEncode(data);
    Response response = await Api().post(
      url: "${constants.BaseURL}/api/subtopics/lessons/",
      body: json_data,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<Lessons> SubTopicLessons = responseData.map(
        (e) {
          return Lessons.fromJson(e);
        },
      ).toList();
      return SubTopicLessons;
    } else {
      print(response.statusCode);
      return [];
    }
  }

  Future<void> FetchMainTopics() async {
    emit(LearingLoading());
    try {
      Response response = await Api().get(
        url: "${constants.BaseURL}/api/topics/",
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        LearningTopics = data.map((e) => LearningModel.fromJson(e)).toList();
        emit(LearningLoaded(LearningTopics));
      } else {
        throw Exception('Failed to load lessons');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  Future<LearningModel?> FetchSubTopic(int Topic_Id) async {
    //emit(LearningSubTopicsLoadingState());
    var data = {"topic_id": Topic_Id};
    var json_data = jsonEncode(data);
    Response response = await Api().post(
      url: "${constants.BaseURL}/api/topics/subtopics/",
      body: json_data,
    );
    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);
      LearningModel SubTopicTotal = LearningModel.fromJson(responseData);
      return SubTopicTotal;
    } else {
      return null;
    }
  }
}

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:des/Api/Api.dart';
import 'package:des/Models/WeeklyModel.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '/constants.dart' as constants;
part 'weekly_state.dart';

class WeeklyCubit extends Cubit<WeeklyState> {
  List<WeelklyModel> Aspects = [];
  List<Map<String, int>> Rating = [];
  WeeklyCubit() : super(WeeklyInitial());

  void IntilizeRatingList() {
    Rating = List.generate(
        Aspects.length, (index) => {'aspect_type_id': index + 1, 'value': 0});
  }

  void UpdateAspects(int id, int value) {
    int existingIndex = Rating.indexWhere((map) => map['aspect_type_id'] == id);
    if (existingIndex != -1) {
      Rating[existingIndex]['value'] = value;
    } else {
      Rating.add({"aspect_type_id": id, "value": value});
    }
  }

  Future<void> GetAspects() async {
    Response response =
        await Api().get(url: "${constants.BaseURL}/api/life-aspect-types/");
    List<dynamic> responseData = jsonDecode(response.body);
    Aspects = responseData.map((json) => WeelklyModel.fromJson(json)).toList();

    IntilizeRatingList();
  }

  Future<void> CreateRecord() async {
    var data = {"scores": Rating};
    var jsonData = jsonEncode(data);
    Response response = await Api().post(
      url: "${constants.BaseURL}/api/life-record/",
      body: jsonData,
    );
    IntilizeRatingList();
  }
}

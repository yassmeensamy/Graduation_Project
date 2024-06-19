import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../constants.dart' as constants;
import '../Models/MeditationModel.dart';

class GetMeditation {
  Future<List<MeditationModel>> GetMeditations() async {

    Response response = await http.get(
      Uri.parse("${constants.BaseURL}/api/meditations/"),
    );
    
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<MeditationModel> Meditations =
          data.map((item) => MeditationModel.fromJson(item)).toList();
      return Meditations;
    } else if (response.statusCode == 401) {
      throw Exception(
          "Unauthorized: Please login or provide valid credentials.");
    } else {
      throw Exception("Failed to load questions");
    }
  }
}

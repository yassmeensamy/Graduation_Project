import 'dart:convert';
import 'package:des/Helper/Api.dart';
import 'package:http/http.dart';
import 'package:des/Models/QuestionModel.dart';

class GetQuestions {
  Future<List<Question>> GetAllQuestions() async {
    Map<String, String> headers = {
      'Authorization':   'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM4NDY5NTM3LCJpYXQiOjE3MDI0Njk1MzcsImp0aSI6IjFhOTQyYjRkOWYxOTRmMTlhNTdlMmZiOWZlYzNjY2NjIiwidXNlcl9pZCI6MzR9.csS8xDUnmUz54CpOkrnwZgo7cKZ6Px-B_vU02QDZCvk'
      // Add any other headers you need
    };

    Response response = await Api().get(
      url: "https://mentally.duckdns.org/api/questions/",
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Question> questions = data.map((item) => Question.fromJson(item)).toList();
      return questions;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: Please login or provide valid credentials.");
    } else {
      throw Exception("Failed to load questions");
    }
  }
}

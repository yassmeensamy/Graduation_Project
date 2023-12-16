import 'dart:convert';
import 'package:des/Helper/Api.dart';
import 'package:http/http.dart';
import 'package:des/Models/QuestionModel.dart';

class GetQuestions {
  Future<List<Question>> GetAllQuestions() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM0Njg3NzIyLCJpYXQiOjE2OTg2ODc3MjIsImp0aSI6IjA4YzFhNjM5MzFlYTRlNzM5YWMyNzg0NjIxOWViNmNmIiwidXNlcl9pZCI6Nn0.6F-WQxseVKAYIhY9NiOyL-Ruy_qvALlgS-29kSn890I', // Replace with your authorization token
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

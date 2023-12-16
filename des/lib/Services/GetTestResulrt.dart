

import 'dart:convert';

import 'package:des/Helper/Api.dart';
import 'package:des/Models/TestResult.dart';
import 'package:http/http.dart';

class GetTestResult 
{
  Future<TestResultModel>GetTestresult(String scores) async 
  {
      Map<String, String> headers = 
      {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM0Njg3NzIyLCJpYXQiOjE2OTg2ODc3MjIsImp0aSI6IjA4YzFhNjM5MzFlYTRlNzM5YWMyNzg0NjIxOWViNmNmIiwidXNlcl9pZCI6Nn0.6F-WQxseVKAYIhY9NiOyL-Ruy_qvALlgS-29kSn890I', // Replace with your authorization token
      "Content-Type": "application/json",
      // Add any other headers you need
      };
    Response response = await Api().post(
      url: "https://mentally.duckdns.org/api/questions/",
      body:scores,
      headers: headers,
    );
    if (response.statusCode == 200) 
    {
     
       Map<String, dynamic> data = jsonDecode(response.body);
       TestResultModel testResult = TestResultModel.fromJson(data);

      return testResult;
    } 
    else if (response.statusCode == 401) 
    {
      throw Exception("Unauthorized: Please login or provide valid credentials.");
    } 
    else {
      throw Exception("Failed to load questions");
    }
  }
}

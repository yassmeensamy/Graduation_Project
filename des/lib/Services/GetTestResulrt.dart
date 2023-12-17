

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
          'Authorization':  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM4NDY5NTM3LCJpYXQiOjE3MDI0Njk1MzcsImp0aSI6IjFhOTQyYjRkOWYxOTRmMTlhNTdlMmZiOWZlYzNjY2NjIiwidXNlcl9pZCI6MzR9.csS8xDUnmUz54CpOkrnwZgo7cKZ6Px-B_vU02QDZCvk',
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

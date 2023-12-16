
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<http.Response> get({required String url, required Map<String, String> headers}) async 
  {
    http.Response response = await http.get(Uri.parse(url),  headers: headers);
    if (response.statusCode == 200) 
    {
      return response;
    } 
    else {
      throw Exception("Problem  ${response.statusCode}");
    }
  }


   Future<http.Response> post({required String url,required dynamic body,required Map<String, String> headers }) async {
    /*
   // Depending on the API
    if (token != null) {
      headers.addAll({
        "Authorization": "Bearer $token",
        "Refresh-Token": refreshToken!,
      });
    }
    */
    http.Response response = await http.post(
      Uri.parse(url), // Use the 'url' parameter
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Request failed");
    }
  }
}


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api
 {
  Future<http.Response> get({required String url}) async 
  {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? accessToken = prefs.getString('accessToken');
     Map<String, String> headers =
      {
         'Authorization': 'Bearer $accessToken',
      };
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    if (response.statusCode == 200) 
    {
               return response;
    } 
    else 
    {
      throw Exception("Problem with status code ${response.statusCode}");
    }
  }
   
   
   Future<http.Response> post({required String url,required dynamic body,}) async
    {
       SharedPreferences prefs = await SharedPreferences.getInstance();
        String? accessToken = prefs.getString('accessToken');     
        Map<String, String> headers = {}; 
        headers.addAll({'Authorization': 'Bearer $accessToken',"Content-Type": "application/json"});
         http.Response response = await http.post(
           Uri.parse(url), // Use the 'url' parameter
           body: body,
          headers: headers, );

    if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
    } 
    else
     {
      
      print("error in post ${response.statusCode}");
      //print(response.body);
       throw Exception("Request failed");
    }
  }
  
  Future<http.Response>delete({ required String url,  dynamic body })
  
  async {
           
       SharedPreferences prefs = await SharedPreferences.getInstance();
        String? accessToken = prefs.getString('accessToken');     
        Map<String, String> headers = {}; 
        headers.addAll({'Authorization': 'Bearer $accessToken','Content-Type': 'application/json',});
        http.Response response = await http.delete( Uri.parse(url), 
        headers: headers,
        body:body,
    );
    if(response.statusCode==200)
    {
    
     return response;
    }
    else 
    { 
     
      return  throw Exception("Request failed");
    }
  }

}

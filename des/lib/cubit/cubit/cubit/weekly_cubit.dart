import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:des/Models/WeeklyModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'weekly_state.dart';


class WeeklyCubit extends Cubit<WeeklyState> 
{
    List<WeelklyModel>Aspects=[];
    List<Map<String,int>>Rating=[];
  WeeklyCubit() : super(WeeklyInitial())
  {
      GetAspects();
  }
 void UpdateAspects(int id, int value) {
  int existingIndex = Rating.indexWhere((map) => map['aspect_type_id'] == id);
  if (existingIndex != -1) 
  {
    Rating[existingIndex]['value'] = value;
  } 
  else {
    Rating.add({"aspect_type_id": id, "value": value});
  }
}
   Future<void> GetAspects() async
  {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       String ? accessToken = prefs.getString('accessToken'); 
      Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };
    http.Response response = await http.get(
      Uri.parse(
        "http://157.175.185.222/api/life-aspect-types/",
      ),
      headers: headers,
    );
    if(response.statusCode==200)
    {
      List<dynamic> responseData = jsonDecode(response.body);
      Aspects= responseData.map((json) =>WeelklyModel.fromJson(json)).toList();
    }
     else 
     {
      print(response.statusCode);
      print("Failed to load questions");
     }
    }

    void CreateRecord() async
    {
    var data = {"scores": Rating};
    print(data);
    var jsonData = jsonEncode(data);
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      
    };
    
    
    
    Response response = await http.post(
      Uri.parse("http://157.175.185.222/api/life-record/"),
      body: jsonData,
      headers: headers,
    );
    if(response.statusCode==201)
    {
      print("done");

    }
    else 
    {
      print(response.statusCode);
      print("off");
    }
    }

  }



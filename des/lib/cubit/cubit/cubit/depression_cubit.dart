import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; 
import '/constants.dart' as constants;
import 'dart:convert';

part 'depression_state.dart';

class DepressionCubit extends Cubit<DepressionState> 
{
   bool checkDepression=false;
   DepressionCubit() : super(DepressionInitial());
  Future<void> CheckDepression() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };

      var response = await http.get(
          Uri.parse("${constants.BaseURL}/api/consecutive-depression-check/"), headers: headers);
      if (response.statusCode == 200) 
      {
        dynamic data = jsonDecode(response.body);
        checkDepression= data["depression_streak"]; 
        print(checkDepression);
      } 
    
    } 
    catch (e) 
    {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

}

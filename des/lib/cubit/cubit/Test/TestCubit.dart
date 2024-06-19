import 'dart:convert';
import 'package:des/cubit/cubit/Test/TestCubitStates.dart';
import 'package:des/cubit/cubit/Test/answer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/constants.dart' as constants;
import '../../../Models/QuestionModel.dart';
import '../../../Models/TestResultModel.dart';

class Testcubit extends Cubit<TestState> {
  String? accessToken ;
  Testcubit() : super(TestLoading());
  List<Question> questions = [];
  List<Map<String, int>> scores = [];
  bool isselected = false; // علشان نعرف هو اتنيل  اختار ولا لا
  int value = -1;
  void getQuestions(BuildContext context) 
  {
    if (questions.isNotEmpty) 
    {
      scores = List.generate(questions.length, (index) => {"value": -1});
      context.read<AnswerCubit>().disSelected();
      emit(TestQuestion(questions));
    }
     else 
     {
          getAllQuestions();
    }
  }
  Future<void> getAllQuestions() async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };
    http.Response response = await http.get(
      Uri.parse(
        "${constants.BaseURL}/api/questions/",
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      questions = data.map((item) => Question.fromJson(item)).toList();
      scores = List.generate(questions.length, (index) => {"value": -1});
      emit(TestQuestion(questions));
    } else if (response.statusCode == 401) {
      emit(TestError(
          "Unauthorized: Please login or provide valid credentials."));
    } else {
      emit(TestError("Failed to load questions"));
    }
  }
void fetchNextQuestions(int currentQuestionIndex, BuildContext context) 
  { 
    /* 
    اول حاجة بيشوف هو السؤال الحالي متجاوب عليه ولا لا 
                                                              اه-هنسجل الاجابه ونزود واحد ونشوف السؤال الجي كان متجاوب قبل كده ولا لا   لو اه ببعت اجابته لو لا  بلغي الحاله بتاعت الاختيار وبيبدا من الاول                                                                  
    */
    if (currentQuestionIndex < questions.length) 
    { 
      if(currentQuestionIndex < questions.length)
      {
       if (isselected) 
      {
           StoreAswers(currentQuestionIndex, value);       
           currentQuestionIndex++; 
           if (currentQuestionIndex < questions.length)   
           {
                if(getCurrentQuestionSelectd(currentQuestionIndex)!=-1)
               { 
                        context.read<AnswerCubit>().Selected(getCurrentQuestionSelectd(currentQuestionIndex));
               }
              else
                 {
                             context.read<AnswerCubit>().disSelected();
                }
                   emit(TestQuestionChanged(currentQuestionIndex));
           } 
           else 
                {
                     fetchFinalScore();
                     ClearScores(context);
                 }
      }
       else 
       {
        displaySnackBar(context);
      }
    }
    }
  }
  int getCurrentQuestionSelectd(int currentIndex)
{
  return scores[currentIndex]['value'] ?? -1;
}
  void ClearScores(BuildContext context) 
  {
    scores = [];
  }
  void fetchPreveriousQuestions(
    int currentQuestionIndex, BuildContext context) {
    if(currentQuestionIndex>0)
    {
       currentQuestionIndex--;
       if(getCurrentQuestionSelectd(currentQuestionIndex)!=-1)
       {
        context.read<AnswerCubit>().Selected(getCurrentQuestionSelectd(currentQuestionIndex));
       }
            emit(TestQuestionChanged(currentQuestionIndex));
    }   
    else 
    {
      ClearScores(context);
      //emit(HomeNaviagtion());
    }
  }

  void displaySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You should answer the previous question"),
        duration: Duration(seconds: 2), // Adjust duration as needed
      ),
    );
  }

  void fetchFinalScore() async 
  {
    

    var data = {"answers": scores};
    var jsonData = jsonEncode(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');

    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      "Content-Type": "application/json"
    };
    Response response = await http.post(
      Uri.parse("${constants.BaseURL}/api/questions/"),
      body: jsonData,
      headers: headers,
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      TestResultModel TestResult = TestResultModel.fromJson(data);
      emit(TestFinished(TestResult));
    } else if (response.statusCode == 401) {
      emit(TestError(
          "Unauthorized: Please login or provide valid credentials."));
    } else {
      emit(TestError("Failed to load questions"));
    }
  }

  void StoreAswers(int currquestion, int value) {
    scores[currquestion]['value'] = value;
    print(scores);
  }
}

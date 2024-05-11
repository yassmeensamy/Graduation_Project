import 'dart:convert';

import 'package:des/cubit/cubit/Test/TestCubitStates.dart';
import 'package:des/cubit/cubit/Test/answer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../../Models/QuestionModel.dart';
import '../../../Models/TestResultModel.dart';

class Testcubit extends Cubit<TestState> {
  Testcubit() : super(TestLoading()) {}
  List<Question> questions = [];
  List<Map<String, int>> scores = [];
  bool isselected = false; // علشان نعرف هو اتنيل  اختار ولا لا
  int value = -1;
  void getQuestions() {
    if (questions.isNotEmpty) {
      scores = List.generate(questions.length, (index) => {"value": -1});
      emit(TestQuestion(questions));
    } else {
      print("odd");
      getAllQuestions();
    }
  }

  Future<void> getAllQuestions() async {
    Map<String, String> headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2MjUwMjg1LCJpYXQiOjE3MTAyNTAyODUsImp0aSI6IjQ2YTg5NWE2ZjBmZDRlMGViNTRlNTk1MDIyMDJiNjg5IiwidXNlcl9pZCI6MX0.mTx7JXgwDzp1N7H9yd5xcKDa92WMK-T_S_PnwWX7vGI',
      // Add any other headers if needed
    };

    http.Response response = await http.get(
      Uri.parse(
        "http://157.175.185.222/api/questions/",
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      questions = data.map((item) => Question.fromJson(item)).toList();
      scores = List.generate(questions.length, (index) => {"value": -1});
      print(scores.length);
      emit(TestQuestion(questions));
    } else if (response.statusCode == 401) {
      emit(TestError(
          "Unauthorized: Please login or provide valid credentials."));
    } else {
      emit(TestError("Failed to load questions"));
    }
  }

  void fetchNextQuestions(int currentQuestionIndex, BuildContext context) {
    if (currentQuestionIndex < questions.length - 1) //اخرها 23
    {
      /*
      if(getAnswer( currentQuestionIndex)==-1)
      {
        context.read<AnswerCubit>().disSelected();
      }
      */
      if (isselected) {
        //final answerCubit = context.read<AnswerCubit>();
        //answerCubit.Selected(context.read<Testcubit>().getAnswer( currentQuestionIndex));
        //print(currquestion);

        StoreAswers(currentQuestionIndex, value);
        currentQuestionIndex++;
        emit(TestQuestionChanged(currentQuestionIndex));
      } else {
        displaySnackBar(context);
      }
    } else {
      StoreAswers(currentQuestionIndex, value);
      fetchFinalScore();
      ClearScores(context);
    }
  }

  int getAnswer(int questionIndex) {
    return scores[questionIndex]['value'] ?? -1;
  }

  void ClearScores(BuildContext context) {
    scores = [];
    context.read<AnswerCubit>().disSelected();
  }

  void fetchPreveriousQuestions(
      int currentQuestionIndex, BuildContext context) {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      final answerCubit = context.read<AnswerCubit>();
      answerCubit.Selected(
          context.read<Testcubit>().getAnswer(currentQuestionIndex));
      emit(TestQuestionChanged(currentQuestionIndex));
    } else {
      ClearScores(context);
      emit(HomeNaviagtion());
      //emit(TestError("Firstpage"));
    }
  }

  void displaySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You should answer the previous question"),
        duration: Duration(seconds: 2), // Adjust duration as needed
      ),
    );
  }

  void fetchFinalScore() async {
    var data = {"answers": scores};
    var jsonData = jsonEncode(data);
    Map<String, String> headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2MjUwMjg1LCJpYXQiOjE3MTAyNTAyODUsImp0aSI6IjQ2YTg5NWE2ZjBmZDRlMGViNTRlNTk1MDIyMDJiNjg5IiwidXNlcl9pZCI6MX0.mTx7JXgwDzp1N7H9yd5xcKDa92WMK-T_S_PnwWX7vGI',
      "Content-Type": "application/json"
      // Add any other headers you need
    };

    Response response = await http.post(
      Uri.parse( "http://157.175.185.222/api/questions/"),
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
  }
}

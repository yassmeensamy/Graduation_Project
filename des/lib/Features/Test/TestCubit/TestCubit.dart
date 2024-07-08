import 'dart:convert';
import 'package:des/Api/Api.dart';
import 'package:des/Features/HomeScreen/HomeCubits/DepressionPlanCubit/depression_cubit.dart';
import 'package:des/Features/Test/Models/QuestionModel.dart';
import 'package:des/Features/Test/Models/TestResultModel.dart';
import 'package:des/Features/Test/TestCubit/TestCubitStates.dart';
import 'package:des/Features/Test/TestCubit/answer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '/constants.dart' as constants;


class Testcubit extends Cubit<TestState> {
  String? accessToken;
  Testcubit(BuildContext context) : super(TestLoading()) {
    getQuestions(context);
  }

  List<Question> questions = [];
  List<Map<String, int>> scores = [];
  bool isselected = false; // علشان نعرف هو اتنيل  اختار ولا لا
  int value = -1;
  void getQuestions(BuildContext context) {
    if (questions.isNotEmpty) {
      scores = List.generate(questions.length, (index) => {"value": -1});
      context.read<AnswerCubit>().disSelected();
      emit(TestQuestion(questions));
    } else {
      getAllQuestions();
    }
  }

  Future<void> getAllQuestions() async {
    Response response =
        await Api().get(url: "${constants.BaseURL}/api/questions/");
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

  Future<void> fetchNextQuestions(int currentQuestionIndex, BuildContext context) async {
    if (currentQuestionIndex < questions.length) {
      if (currentQuestionIndex < questions.length) {
        if (isselected) {
          StoreAswers(currentQuestionIndex, value);
          currentQuestionIndex++;
          if (currentQuestionIndex < questions.length) {
            if (getCurrentQuestionSelectd(currentQuestionIndex) != -1) {
              context
                  .read<AnswerCubit>()
                  .Selected(getCurrentQuestionSelectd(currentQuestionIndex));
            } else {
              context.read<AnswerCubit>().disSelected();
            }
            emit(TestQuestionChanged(currentQuestionIndex));
          } else 
          {
           await fetchFinalScore(context);
            ClearScores(context);
            print("----------------------------------------------------------------------");
            await BlocProvider.of<DepressionCubit>(context).FetchActivityDepresion();
            print("ppppppppppppppppppppppppppppppppppppppppppppppppppp");
          }
        } else {
          displaySnackBar(context);
        }
      }
    }
  }

  int getCurrentQuestionSelectd(int currentIndex) {
    return scores[currentIndex]['value'] ?? -1;
  }
  void ClearScores(BuildContext context) {
    scores = [];
  }
  
  void fetchPreveriousQuestions(
      int currentQuestionIndex, BuildContext context) {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      if (getCurrentQuestionSelectd(currentQuestionIndex) != -1) {
        context
            .read<AnswerCubit>()
            .Selected(getCurrentQuestionSelectd(currentQuestionIndex));
      }
      emit(TestQuestionChanged(currentQuestionIndex));
    } else {
      ClearScores(context);
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

 Future <void >fetchFinalScore(BuildContext context) async {
    var data = {"answers": scores};
    var jsonData = jsonEncode(data);
    Response response = await Api()
        .post(url: "${constants.BaseURL}/api/questions/", body: jsonData);
    if (response.statusCode == 200)
     {
              
      dynamic data = jsonDecode(response.body);
      TestResultModel TestResult = TestResultModel.fromJson(data);

      emit(TestFinished(TestResult));
    } else if (response.statusCode == 401) {
      emit(TestError("Unauthorized: Please login or provide valid credentials."));
    } else {
      emit(TestError("Failed to load questions"));
    }
  }

  void StoreAswers(int currquestion, int value) {
    scores[currquestion]['value'] = value;
    print(scores);
  }
}

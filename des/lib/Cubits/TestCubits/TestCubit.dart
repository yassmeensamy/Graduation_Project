import 'dart:convert';

import 'package:des/Cubits/TestCubits/TestCubitStates.dart';
import 'package:des/GlobalData.dart';
import 'package:des/Models/QuestionModel.dart';
import 'package:des/Models/TestResult.dart';
import 'package:des/Services/GetQuestions.dart';
import 'package:des/Services/GetTestResulrt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Testcubit extends Cubit<TestState> {
  
  Testcubit() : super(TestInitial());

 void fetchQuestions() async {
    try {
      List<Question>? questions = await GetQuestions().GetAllQuestions();
      if (questions.isNotEmpty) 
      {
        emit(TestQuestion(
          questionNumber: 1,
          questions: questions,
          currentQuestion: questions[0],
        ));
      } 
      else 
      {
        emit(TestError("No questions available."));
      }
    } catch (error) {
      emit(TestError(error.toString()));
    }
  }

void fetchNextQuestions() {
    if (state is TestQuestion)
     {
      final currentState = state as TestQuestion;
      int nextQuestionNumber = currentState.questionNumber + 1;
      if (nextQuestionNumber <=currentState.questions.length) {
        final nextQuestion = currentState.questions[nextQuestionNumber - 1];
        emit(TestQuestion
        (
          questionNumber: nextQuestionNumber,
          questions: currentState.questions,
          currentQuestion: nextQuestion,
        ));
      } 
      else
       {
        /*
        for (int i = 0; i < scores.length; i++) 
        {
                  print("Map $i:");
               scores[i].forEach((key, value) {
              print("$key: $value");
         } 
         );
        }
        */
        
           fetchFinalScore(scores) ;
   {
    
   }
      }
    }
  }

void fetchPreviousQuestions() 
{
  if (state is TestQuestion) 
  {
    final currentQuestionState = state as TestQuestion;
    final previousQuestionNumber = currentQuestionState.questionNumber;  //ليه مش بطرح واحدد;
    if (previousQuestionNumber >0)
     {
      final previousQuestion = currentQuestionState.questions[previousQuestionNumber - 1];
      print(currentQuestionState.questions.length);
      emit(TestQuestion(
        questionNumber: previousQuestionNumber,
        questions: currentQuestionState.questions,
        currentQuestion: previousQuestion,
      ));
    } 
    else 
    {
       emit(TestInitial());  // or emit(TestQuestion(questionNumber: 1, questions: currentQuestionState.questions, currentQuestion: currentQuestionState.questions[0]));
    }
  }
}
void fetchFinalScore(List<Map<String, int>> scores) async
{
  //final jsonData = {"answers": scores};
   final jsonData = {
    "answers":scores
  };
  final jsonString = json.encode(jsonData);
  try
  {
         
          TestResultModel TestResult=await GetTestResult().GetTestresult(jsonString);
          emit(TestFinished(TestResult.total_score));
          //print(TestResult.level_of_depression);
         
  }
  catch(error)
  {
    print(error);
         emit(TestError(error.toString()));          
  }
}
}
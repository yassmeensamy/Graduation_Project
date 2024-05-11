

import '../../../Models/QuestionModel.dart';
import '../../../Models/TestResultModel.dart';

class TestState {
  const TestState();
}

class TestInitial extends TestState {}
class TestAnswer extends TestState {}
class TestLoading extends TestState {}

class TestQuestion extends TestState 
{
  List<Question> questions;
    TestQuestion(
    
    this.questions,

  );
  /*
  List<Question> questions;
  int questionNumber;
  Question currentQuestion;

  TestQuestion({
    required this.questionNumber,
    required this.questions,
    required this.currentQuestion,
  });
  */
}

/*
class TestAnswer extends TestState 
{
  final int selectedChoiceScore;
  TestAnswer(this.selectedChoiceScore);
}
*/
class TestFinished extends TestState 
{
  TestResultModel testresult;
  TestFinished(  this.testresult
  );
}

class TestError extends TestState {
  final String errorMessage;

  TestError(this.errorMessage);
}
class TestPreviousstate
{
  TestPreviousstate();
}

class TestQuestionChanged extends TestState {
  final int currentQuestionIndex;
  TestQuestionChanged(this.currentQuestionIndex);
}
class HomeNaviagtion extends TestState
{
  
}
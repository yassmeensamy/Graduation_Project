import 'package:des/Models/QuestionModel.dart';

class TestState {
  
  const TestState();

}

class TestInitial extends TestState {} //home
class TestQuestion extends TestState 
{
  List<Question> questions;
  int questionNumber;
  Question currentQuestion;

  TestQuestion({
    required this.questionNumber,
    required this.questions,
    required this.currentQuestion,
  });
}

class TestFinished extends TestState 
{
  final int finalScore;
  TestFinished( this.finalScore);
}

class TestError extends TestState {
  final String errorMessage;

  TestError(this.errorMessage);
}

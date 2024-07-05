

import 'package:des/Features/Test/Models/QuestionModel.dart';
import 'package:des/Features/Test/Models/TestResultModel.dart';

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
}


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
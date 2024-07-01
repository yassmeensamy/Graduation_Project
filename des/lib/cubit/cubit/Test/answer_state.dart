part of 'answer_cubit.dart';

@immutable
class AnswerState 
{
  int Selectedindex;

  AnswerState({this.Selectedindex=-1});
  AnswerState copyWith (int Selected)
  {
       return AnswerState(Selectedindex : Selected );
  }
  
}




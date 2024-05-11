import 'package:bloc/bloc.dart';
import 'package:des/cubit/cubit/Test/TestCubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'answer_state.dart';

class AnswerCubit extends Cubit<AnswerState> 
{
  final Testcubit testcubit ;
  AnswerCubit({required this.testcubit}) : super(AnswerState());
 
  void Selected(int answer)
  {
    testcubit.isselected=true;
    testcubit.value=answer;
    emit(state.copyWith(answer));
  }
  
  void disSelected()
  {
    testcubit.isselected=false;
    testcubit.value=-1;
    emit(state.copyWith(-1));
  }


}

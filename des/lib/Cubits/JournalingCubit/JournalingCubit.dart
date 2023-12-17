
import 'package:des/Cubits/JournalingCubit/CubitState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class JournalingCubit extends Cubit<JournalingState>
{
  bool isWritingAllowed = true;
  JournalingCubit():super(IntialJournalingState());
  
  void CountLetters(String text) {
  int letterCount =text.replaceAll(' ', '').length;
  if(letterCount>30)
  {
    isWritingAllowed=false;
    emit(limitJournalingState(isWritingAllowed));
  }
  else 
  {
  emit(WritingJouenalingState(letterCount));
  }
}

}
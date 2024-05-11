import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Screens/Home.dart';
import '../../Screens/Insigth/Insigths.dart';
import '../../Screens/Meditation/Exercise.dart';

part 'home_state.dart';
class HomeCubit extends Cubit<HomeState> 
{
  HomeCubit() : super(HomeInitial());
  int currentIndex=0;
  List<Widget>Screens=[Home(),ExerciseScreen(),InsightScreen() ];
  void changeIndex(index)
  {
      currentIndex=index;
      emit(changeIndexState());
  }
}

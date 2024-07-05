
import 'package:des/Features/Insigth/InsigthScreen.dart';
import 'package:des/Features/Learning/Screens/ContentsLearning.dart';
import 'package:des/Features/Meditation/Exercise.dart';
import 'package:des/Features/NewHome.dart';
import 'package:des/Features/Plans/PlansContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';
class HomeCubit extends Cubit<HomeState> 
{
  HomeCubit() : super(HomeInitial());
  int currentIndex=0;
  List<Widget>Screens=[NewHome(),ContentsLearning(),ExerciseScreen(),InsightScreen(),PlansContent() ];
  void changeIndex(index)
  {
      currentIndex=index;
      emit(changeIndexState());
  }
}

// mood_cubit.dart
import 'package:des/cubit/mood_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'EmotionCubit.dart';

class MoodCubit extends Cubit<MoodState> 
{  
  SecondLayerCubit secondLayer;
  MoodCubit(this.secondLayer) : super(MoodState());
  void selectMood(int index) 
  {
    // secondLayer.SelectedMood=index;
    emit(state.copyWith(selectedMoodIndex: index));
  }
  void unselectMood()
   {
    emit(state.copyWith(selectedMoodIndex: -1));
   }

}

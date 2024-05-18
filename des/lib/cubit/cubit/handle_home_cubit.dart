import 'package:bloc/bloc.dart';
import 'package:des/Models/PrimaryEmotionsModel.dart';
import 'package:des/cubit/EmotionCubit.dart';
import 'package:des/cubit/cubit/home_cubit.dart';
import 'package:meta/meta.dart';

part 'handle_home_state.dart';

class HandleHomeCubit extends Cubit<HandleHomeState> {
  final SecondLayerCubit moodCubit;
   List<PrimaryMoodModel> primaryEmotions=[];
  HandleHomeCubit({required this.moodCubit}) : super(HandleHomeInitial());
  void loadHomeData() async {
    emit(HomeLoading());
    try {
      await moodCubit.GetPrimaryEmotions();
      primaryEmotions = moodCubit.primaryEmotions;
      emit(HomeLoaded(primaryEmotions));
    } catch (e) {
      emit(HomeError('Failed to load data: $e'));
    }
  }
  void resetState() {
    emit(HomeLoaded(primaryEmotions));
  }
}


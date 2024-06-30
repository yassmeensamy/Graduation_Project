import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'activity_card_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState>
 {
  ActivitiesCubit() : super(ActivitiesState());

  void selectActivity(int index) 
  {
    final newSelectedActivities = Set.of(state.selectedActivities);
    newSelectedActivities.add(index); 
    emit(state.copyWith(selectedActivities: newSelectedActivities));
  }
  void deselectActivity(int index) 
  {
    final newSelectedActivities = Set.of(state.selectedActivities);
    newSelectedActivities.remove(index); 
    emit(state.copyWith(selectedActivities: newSelectedActivities));
  }
  void selectReason(int index) {
    final newSelectedReasons = Set.of(state.selectedReasons);
    newSelectedReasons.add(index); 
    emit(state.copyWith(selectedReasons: newSelectedReasons));
  }

  void deselectReason(int index) {
    final newSelectedReasons = Set.of(state.selectedReasons);
    newSelectedReasons.remove(index); 
    emit(state.copyWith(selectedReasons: newSelectedReasons));
  }
    void clearAllData() {
    emit(ActivitiesState(selectedActivities: {}));
  }
}

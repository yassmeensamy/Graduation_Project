class ActivitiesState {
  final Set<int> selectedActivities;
  final Set<int> selectedReasons;

  ActivitiesState({
    Set<int>? selectedActivities,
    Set<int>? selectedReasons,
  })  : this.selectedActivities = selectedActivities ?? {},
        this.selectedReasons = selectedReasons ?? {};

  ActivitiesState copyWith({
    Set<int>? selectedActivities,
    Set<int>? selectedReasons,
  }) {
    return ActivitiesState(
      selectedActivities: selectedActivities ?? this.selectedActivities,
      selectedReasons: selectedReasons ?? this.selectedReasons,
    );
  }
}

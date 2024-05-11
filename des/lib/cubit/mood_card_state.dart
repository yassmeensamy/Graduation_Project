// mood_state.dart
class MoodState 
{
  final int selectedMoodIndex;
  MoodState({this.selectedMoodIndex = -1});

  MoodState copyWith({int? selectedMoodIndex}) {
    return MoodState(
      selectedMoodIndex: selectedMoodIndex ?? this.selectedMoodIndex,
    );
  }
}

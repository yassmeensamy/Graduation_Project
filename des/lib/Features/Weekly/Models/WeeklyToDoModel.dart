class WeeklyToDoPlan {
  int id;
  String activityName;
  String activityDescription;
  DateTime createdAt;
  bool isChecked;

  WeeklyToDoPlan({
    required this.id,
    required this.activityName,
    required this.activityDescription,
    required this.createdAt,
    required this.isChecked,
  });

  factory WeeklyToDoPlan.fromJson(Map<String, dynamic> json) {
    return WeeklyToDoPlan(
      id: json['id'],
      activityName: json['activity_name'],
      activityDescription: json['activity_description'],
      createdAt: DateTime.parse(json['created_at']),
      isChecked: json['is_checked'],
    );
  }

}

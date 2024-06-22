class LessonModel {
  int id;
  String name;
  int topicId;

  LessonModel({
    required this.id,
    required this.name,
    required this.topicId,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      name: json['name'],
      topicId: json['topic'],
    );
  }
}

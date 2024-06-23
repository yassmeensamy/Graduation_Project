class Lessons {
  int? id;
  String name;
  Map<String, dynamic> userProgress;
  String? lesson;

  Lessons({
    required this.id,
    required this.name,
    required this.userProgress,
     this.lesson,
  });

  factory Lessons.fromJson(Map<String, dynamic> json) {
    return Lessons(
      id: json['id'],
      name: json['name'],
      userProgress: json['user_progress'],
      lesson: json['content'],
    );
  }
}

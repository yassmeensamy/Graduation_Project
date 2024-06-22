class LearningModel {
  int id;
  String topicName;
  String imagePath;

  LearningModel({
    required this.id,
    required this.topicName,
    required this.imagePath,
  });

  // Factory method
  factory LearningModel.fromJson(Map<String, dynamic> json) {
    return LearningModel(
      id: json['id'] as int,
      topicName: json['name'] ,
      imagePath: json['pic'] ,
    );
  }

}

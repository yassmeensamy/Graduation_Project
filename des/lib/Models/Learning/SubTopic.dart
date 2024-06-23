class SubTopic {
  int id;
  String name;
  int topicId;

  SubTopic({
    required this.id,
    required this.name,
    required this.topicId,
  });

  factory SubTopic.fromJson(Map<String, dynamic> json) 
  {
   
    return SubTopic(
      id: json['id']  ,
      name: json['name'],
      topicId: json['topic'],
    );
  }
}

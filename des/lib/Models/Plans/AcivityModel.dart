class ActivityplanModel {
  final String? message;
  int? id;
  bool ? flag;
  String ? content;
  String? TopicName;
  ActivityplanModel({
    this.message,
     this.id,
     this.flag,
     this.content,
     this.TopicName
  });
  factory ActivityplanModel.fromJson(Map<String, dynamic> json) 
  {
    Map<String, dynamic> depActivity={};
    if(json.containsKey('activity'))
    {
       depActivity = json['activity'];
    }
   
    return ActivityplanModel(
      id: json['number'] ?? json['id'] ?? depActivity['number'],
      flag: json['flag'] ?? depActivity['flag'],
      content: json['text'] ?? depActivity['text'] ?? " ",
      TopicName: json["topic_name"] ??depActivity["topic_name"]??" ",
      message: json['message']??" ",
    );
  }
}

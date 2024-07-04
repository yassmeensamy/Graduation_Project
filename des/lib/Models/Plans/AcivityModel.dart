class ActivityplanModel {
  int? id;
  bool ? flag;
  String ? content;

  ActivityplanModel({
     this.id,
    required this.flag,
     this.content,
  });

  factory ActivityplanModel.fromJson(Map<String, dynamic> json) 
  {
    json=json["activity"];
    return ActivityplanModel(
      id: json['id'] ?? json['number'] ,
      flag: json['flag'] ,
      content: json['text'] ,
    );
  }

  
}

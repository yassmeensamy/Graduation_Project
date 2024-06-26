class ActivityplanModel {
  int? id;
  bool flag;
  String ? content;

  ActivityplanModel({
     this.id,
    required this.flag,
     this.content,
  });

  factory ActivityplanModel.fromJson(Map<String, dynamic> json) 
  {
    return ActivityplanModel(
      id: json['id'] ,
      flag: json['flag'] ,
      content: json['content'] ,
    );
  }
}

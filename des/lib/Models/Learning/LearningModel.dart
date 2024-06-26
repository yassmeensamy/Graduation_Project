import 'package:des/Models/Learning/SubTopic.dart';
import '/constants.dart' as constants;
class LearningModel {
  int id;
  String topicName;
  String imagePath;
  List<SubTopic>? subtopics;
  LearningModel({
    required this.id,
    required this.topicName,
    required this.imagePath,
     this.subtopics,
  }
  );
  factory LearningModel.fromJson(Map<String, dynamic> json)
  {
    Map<String, dynamic>? maintopic = json['topic'];
   List<SubTopic>SubTpoicList=[];
    if(maintopic!=null)
    {
          List<dynamic>Topics= json['subtopics'] ??[];
          if(Topics.isNotEmpty)
          {
                SubTpoicList =Topics.map((e) {return SubTopic.fromJson(e);},).toList();
          }
    }
    return LearningModel(
      id: json['id'] ?? maintopic!["id"],
      topicName: json['name'] ?? constants.BaseURL+maintopic!["name"] ,
      imagePath: json['pic'] ?? maintopic!["pic"],
      subtopics: SubTpoicList,
    );
  }

}
